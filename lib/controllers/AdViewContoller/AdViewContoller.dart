import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:mazad_app/controllers/AuthController/LoginController.dart';
import 'package:mazad_app/helpers/Constants.dart';
import 'package:mazad_app/models/Ad.dart';
import 'package:mazad_app/models/NewComment.dart';
import 'package:mazad_app/services/AuthService.dart';

class AdViewContoller extends GetxController {
  AuthService authService = AuthService();
  Dio dio = Dio();
  var commentText = "test";

  createNewComment(ad) async {
    var newAd = await createNewCommentObject(ad);
    var mapFromObject = newAd.toJson(); //todo uncommit
    // Logger().d(mapFromObject);
    final String encodedData = json.encode(mapFromObject);
    final prettyString = JsonEncoder.withIndent('  ').convert(mapFromObject);
    // Logger().d(prettyString);
    Logger().d(prettyString);



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
    var response =
        await dio.post(url, data: encodedData, options: Options(headers: headers));
    if (response.statusCode == 200) {
      Logger().d("${response.statusCode}");
      Logger().d("${response.data}");

    } else {
      Logger().d("uploadImage  json result :");
    }
  }

  Future<NewComment> createNewCommentObject(ad) async {
    NewComment comment;
    User? user = await Get.find<LoginController>().getLoggedInUserObject();

    comment = NewComment(
      commentText: commentText,
      user: user,
      ad: ad,
      publishedAt: DateTime.now()
    );

    return comment;
  }
}
