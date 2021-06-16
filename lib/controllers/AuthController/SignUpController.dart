import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mazad_app/data/LocalStorage.dart';
import 'package:mazad_app/helpers/Constants.dart';

class SignUpContoller extends GetxController {
  static SignUpContoller get to => Get.find();

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
    // print(data);
    //
  }

  createNewUser2() async {
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse('http://172.27.128.1:1111/auth/local'));
    request.body =
        json.encode({"identifier": "asd@gmail.com", "password": "asdasd"});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
