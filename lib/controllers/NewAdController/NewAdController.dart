import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:mazad_app/controllers/AuthController/LoginController.dart';
import 'package:mazad_app/controllers/HomeController/HomeController.dart';
import 'package:mazad_app/models/Ad.dart';
import 'package:mazad_app/models/NewAd.dart';
import 'package:mazad_app/models/UploadModel.dart';
import 'package:mazad_app/services/NewAddService.dart';

class NewAdController extends GetxController {
  static NewAdController to = Get.find();
  var logger = Logger();

  NewAdService _newAdService = NewAdService();
  final HomeViewController homeViewController =
      Get.put<HomeViewController>(HomeViewController());
  String title = '';
  String content = "";
  List<Tag> tags = <Tag>[];
  String category = "";
  List<String> comments = [];
  int likes = 0;
  DateTime publishedAt = DateTime.now();
  String createdBy = "";
  String updatedBy = "";
  var id;
  var username;

  // dropdown
  var selectedCat = "";
  String? catTitle = "w";

  /// =======================================================
  var titleController = TextEditingController();
  var contentController = TextEditingController();
  var tagsController = TextEditingController();

  List<File> files = [];
  List<File> files2 = [];
  List<Upload> ImagesFilesFromServer = [];
  var pathes = [];
  var path;

  /// =======================================================

  /// form
  GlobalKey<FormState> get formKey => _formKey;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// methods ============================================================

  tester() async {
    // print("A");
    await _newAdService.test();
  }

  chosenImagesSingleImagePicker(ImageSource imageSource) async {
    final File _image;
    files.clear();

    final pickedFile = await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      // print(_image.path);
      logger.d(_image.path);

      files.add(_image);
      update();
    }
    return files;
    // files.clear();
  }

  void _clearCachedFiles() async {
    FilePicker.platform.clearTemporaryFiles().then((result) {
      Get.snackbar(
        'Somthing Wrong',
        'Make Sure Login Info Is Correct',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     backgroundColor: result == true ? Colors.green : Colors.red,
      //     content: Text((result == true
      //         ? 'Temporary files removed with success.'
      //         : 'Failed to clean temporary files')),
      //   ),
      // );
    });
  }

  chosenImagesMultiFilePicker(context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );

    if (result != null) {
      files2.clear();
      var chosenImages = result.paths.map((path) => File(path!)).toList();

      for (File file in chosenImages) {
        String path = file.path;
        pathes.add(path);
        // logger.d("path : ${path}");
        // print("path : ${path}");
        files2.add(file);
      }
      // PlatformFile file = result.files.first;
      // print(file.name);
      // print(file.bytes);
      // print(file.size);
      // print(file.extension);
      // print(file.path);
      // print("files2 : ${files2.length}");
    } else {
      // User canceled the picker
    }

    update();
  }

  Future<List<Upload>> uploadImage(List<File> files) async {
    File file = files.first;

    try {
      ImagesFilesFromServer = await _newAdService
          .uploadImage(file)
          .catchError((onError) => printError(info: onError.toString()));
      // print(ImagesFilesFromServer.length);
    } catch (e) {
      print(e);
    }
    return ImagesFilesFromServer;
  }

  Future<NewAd> adFromInput() async {
    NewAd ad;
    // var image;

    /// trying single image
    var UploadImage = await uploadImage(files);
    // String json = jsonEncode(UploadImage);
    // logger.d(json);
    Upload image = Upload();

    for (Upload q in UploadImage) {
      image = q;
      // logger.d(image.toJson());
    }

    // todo first upload image to backend then take the id and url and linked to new ad object

    // var map = UploadImage.map((e) => e.toJson());
    // logger.d(map);

    /// trying multi image

    catTitle = selectedCat;
    //  get User name
    username = await Get.find<LoginController>()
        .getUser()
        .then((value) => value!.username);
    id = await Get.find<LoginController>().getUser().then((value) => value!.id);
    var ImageId = image.id;
    var ImageUrl = image.url;

    ad = NewAd(
      title: title,
      content: content,
      user: User(id: id, username: username),
      tags: tags,
      category: Category(id: 2, title: catTitle),
      comments: comments,
      likes: 50,
      // images: <AdImage>[AdImage(id: ImageId!, name: ImageUrl!)],
      publishedAt: publishedAt,
      createdBy: createdBy,
      updatedBy: updatedBy,
    );

    // print(ad.category!.title);
    return ad;
  }

  sendToServer() async {
    var newAd = await adFromInput();
    var mapFromObject = newAd.toJson(); //todo uncommit
    print(mapFromObject);
    // await _newAdService.createNewAd(mapFromObject);
  }

  List<String>? _dropDownMenuItemsStrings = <String>[];

  List<String>? get dropDownMenuItemsStrings => _dropDownMenuItemsStrings;

  List<DropdownMenuItem<String>> getCats() {
    var list = Get.find<HomeViewController>();
    _dropDownMenuItemsStrings =
        list.categories.map((e) => e.title).cast<String>().toList();
    var list2 = _dropDownMenuItemsStrings!
        .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
        .toList();
    return list2;
    // update();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    await injectValues();
  }

  injectValues() async {
    getCats();
    update();
  }
}
