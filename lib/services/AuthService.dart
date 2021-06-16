import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mazad_app/data/LocalStorage.dart';
import 'package:mazad_app/helpers/Constants.dart';
import 'package:mazad_app/models/Ad.dart';

class AuthService {
  // LoginController _loginController = Get.find();

  var token;

  Future<bool> userLogin(identifier, password) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('$BaseUrl$AuthUrlLogin'));
    request.body =
        json.encode({"identifier": "$identifier", "password": "$password"});
    request.headers.addAll(headers);

    http.StreamedResponse streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      var jwtToken = data['jwt'];
      // print(data);
      storage.saveToken("jwt", jwtToken);
      print(" Token From Login : $jwtToken");
      var a = await storage.readToken();
      print(" Token From app : $a");
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }

  // get Logged User Id
  LocalStorage storage = LocalStorage();

  // get Logged User Id
  getLoggedUserId() async {
    var isUserLogged = await storage.readToken();
    if (isUserLogged != 0) {
      token = isUserLogged;
      // print(token);
    } else {
      // print("getLoggedUserId : error in user token");
    }
    return token;
  }

  // Future getLoggedUserId2() async {
  //   var isUserLogged = _loginController.userLogged.value;
  //   // var getUserId =  await getUserId();
  //
  //   if (isUserLogged) {
  //     return "Ok";
  //   } else {
  //     print("getLoggedUserId : error in user token");
  //   }
  // }

  Future getUserApi() async {
    var url = "$BaseUrl/users/me";
    String userToken = await getLoggedUserId();
    // print(userToken.toString());
    // print(userToken.runtimeType);

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
    var a = userFromJson(response.body);

    if (response.statusCode == 200) {
      // print("getUserApi  json result : $data");
      // print("getUserApi  json result : ${data.runtimeType}");
      // print("getUserApi  json result : ${a.email}");

      return a;
    }
  }
}
