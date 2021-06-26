import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:mazad_app/controllers/NewAdController/NewAdController.dart';
import 'package:mazad_app/helpers/Constants.dart';
import 'package:mazad_app/utils/app_state.dart';
import 'package:photo_view/photo_view.dart';

/// todo : implemnt logic and move it to controller
class NewAdView extends GetView<NewAdController> {
  @override
  Widget build(BuildContext context) {
    var file = controller.ImagesFilesFromServer;
    Logger().d("files from server " + "${file.length}");

    return Scaffold(

      key: UniqueKey(),
      resizeToAvoidBottomInset: true,
      bottomSheet: _buildBottomSheet(),
      appBar: AppBar(
        title: Text(
          // "إعلان جديد",
          "${controller.dropDownMenuItemsStrings!.length}",
          style: fontStyle.copyWith(color: Colors.white, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // textDirection: TextDirection.rtl,
          children: [
            Card(
              child: Container(
                height: 100,
                // color: Colors.blue,
                child: GestureDetector(
                  onTap: () => Logger().d("Cliked"),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(const Radius.circular(10.0)),
                              color: Colors.white,
                            ),
                            height: 100,
                            width: 120,
                            child: TextButton.icon(
                              onPressed: () async {
                                Get.bottomSheet(
                                  imagePicker(context),
                                );
                                // await controller.pickImage(ImageS);
                              },
                              icon: Icon(
                                Icons.add_a_photo,
                                color: Colors.blue.shade300,
                              ),
                              label: Text(
                                "أضف صور",
                                style: fontStyle.copyWith(
                                    fontSize: 14, color: Colors.black87),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      // Expanded(
                      //   flex: 4,
                      //   child: GetBuilder<NewAdController>(
                      //       init: NewAdController(),
                      //       dispose: (_) => controller.files2.clear(),
                      //       builder: (c) {
                      //         return ListView(
                      //           scrollDirection: Axis.horizontal,
                      //           children: List.generate(
                      //               // controller.files2.length, (index) {
                      //               5, (index) {
                      //             if (c.files2.length != 0) {
                      //               return Padding(
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: Container(
                      //                   decoration: BoxDecoration(
                      //                     borderRadius: BorderRadius.all(
                      //                         const Radius.circular(10.0)),
                      //                     color: Colors.grey.shade200,
                      //                   ),
                      //                   height: 60,
                      //                   width: 100,
                      //                   child: Image.file(
                      //                       controller.files2[index],fit: BoxFit.fill,),
                      //                 ),
                      //               );
                      //             } else if (c.files2.length == 0) {
                      //               return Padding(
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: Container(
                      //                   decoration: BoxDecoration(
                      //                     borderRadius: BorderRadius.all(
                      //                         const Radius.circular(10.0)),
                      //                     color: Colors.red.shade200,
                      //                   ),
                      //                   height: 60,
                      //                   width: 100,
                      //                   child: Icon(Icons.add_a_photo),
                      //                 ),
                      //               );
                      //             } else {
                      //               return CircularProgressIndicator();
                      //             }
                      //           }),
                      //         );
                      //       }),
                      // ),
                      Expanded(
                        flex: 4,
                        child: GetBuilder<NewAdController>(
                            init: NewAdController(),
                            // dispose: (_) => controller.files2.clear(),
                            builder: (c) {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.files2.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                      onTap: () {
                                        Logger().d("sans-serif");
                                      },
                                      child: ImageItem(c.files2[index]));
                                },
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Container(
            //     height: 140,
            //     width: 200,
            //     child: Image.file(controller.files.first)),
            // Container(
            //     height: 140,
            //     width: 200,
            //     child: Image.network("${"$BaseUrl"}/${controller.ImagesFilesFromServer[0].url!}")),
            SizedBox(
              height: 16,
            ),
            // Text("AddNewAdView"),
            SizedBox(
              height: 16,
            ),
            FormUi(),
          ],
        ),
      ),
    );
  }

  Widget FormUi() {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: controller.formKey,
            child: ListView(
              children: [
                TextFormField(
                  maxLength: 32,
                  minLines: 1,
                  keyboardType: TextInputType.text,
                  controller: controller.titleController,
                  maxLines: 1,
                  validator: (value) {
                    return value!.length < 10
                        ? 'Name must be greater than 10 characters'
                        : null;
                  },
                  // style: UtilsImporter().uStyleUtils.loginTextFieldStyle(),
                  decoration: textFieldDecorationCircle(
                    hint: "TV",
                    lable: 'عنوان الإعلان',
                    style: fontStyle.copyWith(
                      color: Colors.black26,
                    ),
                    icon: Icon(Icons.title),
                  ),
                  textDirection: TextDirection.rtl,
                  onSaved: (String? val) {
                    controller.title = val!;
                  },

                  onChanged: (String? val) {
                    controller.title = val!;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  maxLength: 5000,
                  keyboardType: TextInputType.text,
                  controller: controller.contentController,
                  maxLines: 10,
                  validator: (value) {
                    return value!.length < 20
                        ? 'content must be greater than 10 characters'
                        : null;
                  },
                  // style: UtilsImporter().uStyleUtils.loginTextFieldStyle(),
                  decoration: textFieldDecorationCircle(
                    hint: "TV",
                    lable: 'تفاصيل الإعلان',
                    style: fontStyle.copyWith(
                      color: Colors.black26,
                    ),
                    icon: Icon(Icons.title),
                  ),
                  onSaved: (String? val) {
                    controller.content = val!;
                  },
                  onTap: () {},
                  onChanged: (String? val) {
                    controller.content = val!;
                  },
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  // height: 100,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: new DropdownButtonFormField(
                      items: controller.getCats(),
                      style: fontStyle.copyWith(fontSize: 16),
                      isExpanded: true,
                      onChanged: (value) {
                        controller.selectedCat = "$value";
                        controller.catTitle = controller.selectedCat;
                        Logger().d("${controller.catTitle}");
                        // Logger().d("${controller.selectedCat}");
                      },
                      hint: Center(
                        child: Text(
                          "إختر التصنيف",
                          style: fontStyle.copyWith(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
                // Image.memory(controller.path),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSheet() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: MaterialButton(
                child: Obx(
                  () {
                    if (controller.appState() == AppState.LOADING) {
                      return CircularProgressIndicator(
                        color: Colors.white,
                      );
                    }
                    // if (controller.appState() == AppState.ERROR) {
                    //   return FlatButton(
                        // child: Text('مشكلة  حاول مرة أخرى ',style: fontStyle,),
                    //     onPressed: () async => controller.sendToServer(),
                    //   );
                    // }
                    return Text(
                      'رفع الإعلان',
                      style:
                          fontStyle.copyWith(color: Colors.white, fontSize: 18),
                    );
                  },
                ),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                color: kPrimaryColor,
                onPressed:() async{
                  var  ok = await controller.sendToServer();
                  if(ok) await controller.showOkMessage();

                }),
          ),
        ],
      ),
    );
  }

  Widget imagePicker(context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
      ),
      child: Wrap(
        alignment: WrapAlignment.end,
        crossAxisAlignment: WrapCrossAlignment.end,
        children: [
          ListTile(
            leading: Icon(Icons.camera),
            title: Text('كاميرا', style: fontStyle),
            onTap: () async {
              Get.back();
              await controller
                  .chosenImagesSingleImagePicker(ImageSource.camera);
              // await controller.tester();
            },
          ),
          ListTile(
            leading: Icon(Icons.image),
            title: Text(
              'معرض الصور',
              style: fontStyle,
            ),
            onTap: () async {
              controller.files2.clear();
              Get.back();
              await controller.chosenImagesMultiFilePicker(context);
              // await controller.chosenImagesSingleImagePicker(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }
}

class ImageItem extends StatelessWidget {
  final File? url;

  ImageItem(this.url);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (url == null) return Text('no image');
    return GestureDetector(
      onTap: () =>
          PhotoView(imageProvider: AssetImage("assets/icons/home.png")),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.file(url!),
      ),
    );
  }
}
