import 'dart:convert';

import 'package:get/get.dart';
import 'package:mazad_app/data/LocalStorage.dart';
import 'package:mazad_app/helpers/Constants.dart';
import 'package:http/http.dart' as http;

class SignUpContoller extends GetxController {

  String email = "", password = "", name = "";
  RxBool userLogged = false.obs;
  LocalStorage storage = LocalStorage();

  createNewUser() async {
    var url = "$BaseUrl/auth/local/register";
    var body = jsonEncode({
      "username": "$name",
      "email": "$email",
      "password": "$password",
    });
    var response =
        await http.post(Uri.parse("$url"), headers: headersNoAuth, body: body);
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      var jwtToken = data['jwt'];
      storage.saveToken("jwt", jwtToken);
      print(data['jwt']);
    }
    print(data);
    //
  }
}