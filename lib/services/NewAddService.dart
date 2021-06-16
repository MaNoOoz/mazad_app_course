import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:logger/logger.dart';
import 'package:mazad_app/helpers/Constants.dart';
import 'package:mazad_app/models/UploadModel.dart';
import 'package:mazad_app/services/AuthService.dart';

class NewAdService {
  AuthService authService = AuthService();
  Dio dio = Dio();

  /// ===============================================================================================

  Future createNewAd(Map<String, dynamic> body) async {
    var url = "$BaseUrl/ads/";
    String userToken = await authService.getLoggedUserId();
    // print(body);
    // print(userToken.toString());
    // print(userToken.runtimeType);

    var headers = {
      'Authorization': 'Bearer $userToken',
      'Content-Type': 'application/json'
    };
    final String encodedData = json.encode(body);
    Logger().d(encodedData);

    var response = await http
        .post(Uri.parse("$url"), headers: headers, body: encodedData)
        .catchError((dynamic e) {
      print("Error");
      print("${e.toString()}");
    });
    print(response.statusCode);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("createNewAd  json result :$data");
    }
  }

  /// ===============================================================================================

  Future uploadImage(File file) async {
    // https://www.youtube.com/watch?v=0MO1QyEGIt0
    var url = "$BaseUrl/upload/";
    String userToken = await authService.getLoggedUserId();
    var headers = {
      'Authorization':
          // 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjEsImlhdCI6MTYyMzc0NDU4NiwiZXhwIjoxNjI2MzM2NTg2fQ.cXInAifRBjoT8bx_50uKbKBQMdkdgFgyaGYX9-OkvAk',
          'Bearer $userToken',
      'Content-Type': 'multipart/form-data'
    };

    var files = await MultipartFile.fromFile(file.path,
        filename: file.path.split("/").last,
        contentType: MediaType('image', 'png'));
    var type = "image/jpg";
    var body = {"files": files, "type": type};

    FormData formData = FormData.fromMap(body);

    print("files count in body in map ${formData.files.length}");

    Response response = await dio.post(url, data: formData, options: Options(headers: headers));
    if (response.statusCode == 200) {
      log("${response.statusCode}");
      log("${response.data.runtimeType}");

      // final prettyString = JsonEncoder.withIndent('  ').convert(response.data);
      // log("OK $prettyString");

      List<Upload> listOfImages = [];
      List<dynamic> dataList = response.data;
      var json_object = dataList.map((dynamic e) => e).toList();
      for (var s in json_object) {
        final upload = Upload.fromJson(s);
        listOfImages.add(upload);
      }
      return listOfImages;
    } else {
      print("uploadImage  json result :");
    }
  }

  /// ===============================================================================================

  Future uploadImages(List<File> pickedFiles) async {
    var formData = FormData();

    for (var file in pickedFiles) {
       formData.files.addAll([
        MapEntry("files", await MultipartFile.fromFile(file.path,filename: file.path.split("/").last, contentType: MediaType('image', 'jpg'))),
      ]);
      print(file.path);
      print(formData.files[0].value);
    }
    var url = "$BaseUrl/upload/";
    String userToken = await authService.getLoggedUserId();
    var headers = {
      'Authorization':
      // 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjEsImlhdCI6MTYyMzc0NDU4NiwiZXhwIjoxNjI2MzM2NTg2fQ.cXInAifRBjoT8bx_50uKbKBQMdkdgFgyaGYX9-OkvAk',
      'Bearer $userToken',
      'Content-Type': 'multipart/form-data'
    };
    Response response = await dio.post(url, data: formData, options: Options(headers: headers));
    if (response.statusCode == 200) {
      log("${response.statusCode}");
      log("${response.data.runtimeType}");
      // Logger().d("${response.data.toString()}");
      List<Upload> listOfImages = [];
      List<dynamic> dataList = response.data;
      var json_object = dataList.map((dynamic e) => e).toList();
      for (var s in json_object) {
        final upload = Upload.fromJson(s);
        listOfImages.add(upload);
      }
      return listOfImages;
    } else {
      print("uploadImage  json result :");
    }

  }

  Future test() async {
    var url = "https://jsonplaceholder.typicode.com/users";
    var response = await dio.get(url);
    if (response.statusCode == 200) {
      log("${response.statusCode}");
      log("${response.data.runtimeType}");
      var data = response.data as List;

      // final prettyString = JsonEncoder.withIndent('  ').convert(response.data);
      // log("OK $prettyString");

      log("${data.map((e) => e).map((e) => e['address']['street'])}");
      // log("${response.data['address']['street']}");
      // log("${response.data['medium']}");

    }
  }
}
