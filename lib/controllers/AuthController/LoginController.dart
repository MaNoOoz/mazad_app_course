


import 'dart:convert';

import 'package:get/get.dart';
import 'package:mazad_app/Screens/HomeView/HomeView.dart';
import 'package:mazad_app/helpers/Constants.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {

  String email = "", password="", name="";
  RxBool userLogged = false.obs;

  loginUser() async {
    var url = "$BaseUrl/auth/local";
    var body = jsonEncode({
      "identifier": "$email",
      "password": "$password",
    });
    var response =
    await http.post(Uri.parse("$url"), headers: headersNoAuth, body: body);
    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      var jwtToken = data['jwt'];
      // localStorage.saveToken("jwt", jwtToken);
      print(" Token From Login : $jwtToken");

      Get.to(() => HomeView());
    }
  }
}