import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:mazad_app/Bindings/Routers.dart';
import 'package:mazad_app/controllers/AuthController/LoginController.dart';
import 'package:mazad_app/controllers/HomeController/HomeController.dart';
import 'package:mazad_app/helpers/Constants.dart';
import 'package:mazad_app/models/Ad.dart';
import 'package:mazad_app/models/NewAd.dart';
import 'package:mazad_app/models/UploadModel.dart';
import 'package:mazad_app/services/NewAddService.dart';
import 'package:mazad_app/utils/app_state.dart';

class NewAdController extends GetxController {
  static NewAdController to = Get.find();
  var logger = Logger();

  NewAdService newAddService = NewAdService();
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
  var userId;
  var username;
  var catId;

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
  final appState = Rx<AppState>(AppState.IDLE);

  /// =======================================================

  /// form
  GlobalKey<FormState> get formKey => _formKey;
  final GlobalObjectKey<FormState> _formKey =
      GlobalObjectKey<FormState>("_UploadFormState");

  /// methods ============================================================

  tester() async {
    // Logger().d("A");
    await newAddService.test();
  }

  cleanControllers() {
    titleController.text = "";
    contentController.text = "";
    tagsController.text = "";
  }

  chosenImagesSingleImagePicker(ImageSource imageSource) async {
    final File _image;
    files.clear();

    final pickedFile = await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      // Logger().d(_image.path);
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
        // Logger().d("path : ${path}");
        files2.add(file);
      }
      logger.d("files2 leng : ${files2.length}");

      // PlatformFile file = result.files.first;
      // Logger().d(file.name);
      // Logger().d(file.bytes);
      // Logger().d(file.size);
      // Logger().d(file.extension);
      // Logger().d(file.path);
      // Logger().d("files2 : ${files2.length}");
    } else {
      // User canceled the picker
    }

    update();
  }

  Future<List<Upload>> uploadImage(List<File> files) async {
    File file = files.first;

    try {
      ImagesFilesFromServer = await newAddService
          .uploadImage(file)
          .catchError((onError) => printError(info: onError.toString()));
      // Logger().d(ImagesFilesFromServer.length);
    } catch (e) {
      Logger().d(e);
    }
    return ImagesFilesFromServer;
  }

  Future<NewAd> adFromInput() async {
    NewAd ad;
    // var image;

    // /// trying single image
    // var UploadImage = await uploadImage(files);
    // // String json = jsonEncode(UploadImage);
    // // logger.d(json);
    // Upload image = Upload();
    //
    // for (Upload q in UploadImage) {
    //   image = q;
    //   // logger.d(image.toJson());
    // }

    // todo first upload image to backend then take the id and url and linked to new ad object [*]

    // var map = UploadImage.map((e) => e.toJson());
    // logger.d(map);

    /// trying multi image
    // todo first upload images to backend related to an object [*]

    List UploadImage = await newAddService.uploadImages(files2);
    List<AdImage> list = [];

    for (Upload a in UploadImage) {
      var mapFromObject = a.toJson();
      AdImage imageFromUploadMoedl = AdImage.fromJson(mapFromObject);
      // logger.d(imageFromUploadMoedl.id);
      list.add(imageFromUploadMoedl);
    }
    // logger.d(list.length);

    catTitle = selectedCat;
    //  get User name
    username = await Get.find<LoginController>()
        .getUser()
        .then((value) => value!.username);
    userId = await Get.find<LoginController>().getUser().then((value) => value!.id);
    var catList = Get.find<HomeViewController>().categories;

    var cat = catList.map((e) => e).where((element) => element.title==catTitle).toList();
    catId = cat.map((e) => e.id.toString());
    Logger().d("WW"+catId.toString());

    // var ImageId = image.id;
    // var ImageUrl = image.url;

    ad = NewAd(
      title: title,
      content: content,
      user: User(id: userId, username: username),
      tags: tags,
      category: Category(id: catId, title: catTitle),
      comments: comments,
      likes: 50,
      images: list,
      publishedAt: publishedAt,
      createdBy: createdBy,
      updatedBy: updatedBy,
    );

    // logger.d(ad.images);
    return ad;
  }

  showOkMessage() async {
    Get.snackbar(
      "",
      "",
      titleText: Text(
        "تمام",
        style: fontStyle.copyWith(color: Colors.white),
      ),
      messageText: Text(
        "تم رفع الإعلان بنجاح",
        style: fontStyle.copyWith(color: Colors.white),
      ),
      backgroundColor: Colors.green,
      icon: Icon(
        Icons.done_rounded,
        color: Colors.white,
      ),
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 3),
      backgroundGradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.green,
          // Colors.green.shade200,
          // Colors.green.shade300,
          // Colors.green.shade400,
          // Colors.green.shade500,
          Colors.green.shade800,
        ],
      ),
      colorText: Colors.white,
    );
  }

  showNotOkMessage() async {
    Get.snackbar(
      "",
      "",
      titleText: Text(
        "خطأ",
        style: fontStyle.copyWith(color: Colors.white),
      ),
      messageText: Text(
        "يجب عليك إختيار صورة قبل رفع الإعلان",
        style: fontStyle.copyWith(color: Colors.white),
      ),
      backgroundColor: Colors.red,
      icon: Icon(
        Icons.error,
        color: Colors.white,
      ),
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 3),
      backgroundGradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.red,
          // Colors.green.shade200,
          // Colors.green.shade300,
          // Colors.green.shade400,
          // Colors.green.shade500,
          Colors.red.shade800,
        ],
      ),
      colorText: Colors.white,
    );
  }

  Future<bool> sendToServer() async {
    if (files2.length == 0) {
      showNotOkMessage();
    }
    if (formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        appState.value = AppState.LOADING;

        var newAd = await adFromInput();
        var mapFromObject = newAd.toJson(); //todo uncommit
        // logger.d(mapFromObject.length);
        await newAddService.createNewAd(mapFromObject);
        appState.value = AppState.DONE;

        // await showOkMessage();
        // Get.back();
        await Get.offAndToNamed(Routers.initialRoute);
      } on Exception catch (_) {
        await showNotOkMessage();

        appState.value = AppState.ERROR;
      }
      return true;
    }
    return false;
  }

  List<String>? _dropDownMenuItemsStrings = <String>[];

  List<String>? get dropDownMenuItemsStrings => _dropDownMenuItemsStrings;

  List<DropdownMenuItem<String>> getCats() {
    var list = Get.find<HomeViewController>().categories;
    _dropDownMenuItemsStrings =
        list.map((e) => e.title).cast<String>().toList();
    var list2 = _dropDownMenuItemsStrings!
        .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
        .toList();
    return list2;
    // update();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    // cleanControllers();
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
