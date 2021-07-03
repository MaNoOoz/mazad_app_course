import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:mazad_app/Bindings/Routers.dart';
import 'package:mazad_app/controllers/AuthController/LoginController.dart';
import 'package:mazad_app/helpers/Constants.dart';
import 'package:mazad_app/models/Ad.dart';
import 'package:mazad_app/models/NewComment.dart';
import 'package:mazad_app/services/AuthService.dart';
import 'package:mazad_app/utils/app_state.dart';
import 'package:url_launcher/url_launcher.dart';

class AdViewContoller extends GetxController {
  AuthService authService = AuthService();
  Dio dio = Dio();
  var commentText = "test";
  final appState = Rx<AppState>(AppState.IDLE);
  final GlobalObjectKey<FormState> _send_comment_Key =
      GlobalObjectKey<FormState>("_SendCommentsBtn");

  GlobalObjectKey<FormState> get send_comment_Key => _send_comment_Key;

  Future showOkMessage() async {
    Get.snackbar(
      "",
      "",
      titleText: Text(
        "تمام",
        style: fontStyle.copyWith(color: Colors.white),
      ),
      messageText: Text(
        "تم إضافه التعليق بنجاح",
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

  Future showConfirmAlert(model) async {
    await Get.defaultDialog(
      title: "تنبيه",
      titleStyle: fontStyle.copyWith(color: Colors.blue),
      content: Text(
        "إرسال التعليق",
        style: fontStyle,
      ),
      confirm: TextButton(
        onPressed: () async => createNewComment(model),
        child: Text("نعم"),
      ),
      cancel: TextButton(
        onPressed: () => Get.back(),
        child: Text("لا"),
      ),
    );
  }

  Future contactWhatsApp(Ad model, String message) async {
    String url = "whatsapp://send?phone=${model}&text=$message";
    await canLaunch(url) ? launch(url) : printError(info: "canot open");
  }

  Future createNewComment(ad) async {
    appState.value = AppState.LOADING;

    var newAd = await createNewCommentObject(ad);
    var mapFromObject = newAd.toJson(); //todo uncommit
    // Logger().d(mapFromObject);
    await Future.delayed(Duration(seconds: 3));

    final String encodedData = json.encode(mapFromObject);
    // final prettyString = JsonEncoder.withIndent('  ').convert(mapFromObject);
    // Logger().d(prettyString);
    // Logger().d(prettyString);

    var url = "$BaseUrl/comments";

    // var body = jsonEncode({
    //   "CommentText": "$commentText",
    //   "user": "string",
    //   "ad": "string",
    //   "published_at": "2021-06-21T23:29:27.278Z",
    //   "created_by": "string",
    //   "updated_by": "string"
    // });

    String userToken = await authService.getLoggedUserId();
    var headers = {
      'Authorization':
          // 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjEsImlhdCI6MTYyMzc0NDU4NiwiZXhwIjoxNjI2MzM2NTg2fQ.cXInAifRBjoT8bx_50uKbKBQMdkdgFgyaGYX9-OkvAk',
          'Bearer $userToken',
      'Content-Type': 'application/json'
    };
    var response = await dio.post(
      url,
      data: encodedData,
      options: Options(
        headers: headers,
        receiveTimeout: 5000,
      ),
    );
    if (response.statusCode == 200) {
      Logger().d("${response.statusCode}");
      Logger().d("${response.data}");
      await showOkMessage();
      Get.offAndToNamed(Routers.initialRoute);
    } else {
      Logger().d("uploadImage  json result :");
    }
    appState.value = AppState.DONE;
  }

  Future<NewComment> createNewCommentObject(ad) async {
    NewComment comment;
    User? user = await Get.find<LoginController>().getLoggedInUserObject();

    comment = NewComment(
        commentText: commentText,
        user: user,
        ad: ad,
        publishedAt: DateTime.now());

    return comment;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Logger().d("onInit");
  }
}
