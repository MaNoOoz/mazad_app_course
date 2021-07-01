import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:mazad_app/Bindings/Routers.dart';
import 'package:mazad_app/data/LocalStorage.dart';
import 'package:mazad_app/helpers/Constants.dart';
import 'package:mazad_app/models/Ad.dart';

import '../helpers/Constants.dart';

class AuthService {
  var token;
  LocalStorage storage = LocalStorage();
  User? user;

  Future<User?> userLogin(identifier, password) async {
    var headers = {'Content-Type': 'application/json'};
    var body =
        jsonEncode({"identifier": "$identifier", "password": "$password"});
    var response = await http.post(Uri.parse('$BaseUrl$AuthUrlLogin'),
        headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      var jwtToken = data['jwt'];
      var userData = data['user'];
      // // Logger().d(data);
      storage.saveToken("jwt", jwtToken);
      Logger().d(" Token From Login response: $jwtToken");
      Logger().d(" Token From Login response: ${userData.runtimeType}");
      user = User.fromJson(userData);
      Logger().d(" Token From Login response: ${user!.email}");

      // AuthStore.to.saveToken(jwtToken);

      var a = await storage.readToken();
      Logger().d(" Token From app : $a");
      return user;
    } else {
      Logger().d(response.reasonPhrase);
      // return false;
    }
    return null;
  }

  Future<bool> userSignUp({identifier, password, email}) async {
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      "username": "$identifier",
      "email": "$email",
      "password": "$password",
    });
    var response = await http.post(Uri.parse('$BaseUrl$AuthUrlRegister'),
        headers: headers, body: body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      Logger().d("userSignUp  json result : $data");
      // Logger().d("getUserApi  json result : ${data.runtimeType}");
      // Logger().d("getUserApi  json result : ${a.email}");
      return true;
    }
    return false;
  }

   signOutUser() async {
    await LocalStorage().deleteToken();
    user = null;
    token = null;
    // Get.back();
    if (user == null && token == null){
      Get.offAllNamed(Routers.initialRoute);
    }

  }

   getLoggedUserId() async {
    var isUserLogged = await storage.readToken();
    if (isUserLogged != 0) {
      token = isUserLogged;
      // Logger().d(token);
    } else {
      // Logger().d("getLoggedUserId : error in user token");
    }
    return token;
  }

  Future<dynamic> getMe() async {
    var url = "$BaseUrl/users/me";
    String userToken = await getLoggedUserId();
    // Logger().d(userToken.toString());
    // Logger().d(userToken.runtimeType);

    Map<String, String> headersAuth = {
      'Content-Type': 'application/json',
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*",
      "Authorization": "Bearer $userToken",
    };

    var response = await http.get(
      Uri.parse("$url"),
      headers: headersAuth,
    );
    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // Logger().d("getUserApi  json result : $data");
      // Logger().d("getUserApi  json result : ${data.runtimeType}");
      // Logger().d("getUserApi  json result : ${a.email}");

      return data;
    }
  }
}
