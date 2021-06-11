import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mazad_app/Screens/HomeView/HomeView.dart';
import 'package:mazad_app/data/LocalStorage.dart';
import 'package:mazad_app/helpers/Constants.dart';
import 'package:mazad_app/helpers/StarterView.dart';
import 'package:mazad_app/models/User.dart';
import 'package:mazad_app/services/AuthService.dart';

class LoginController extends GetxController {
  String identifier = "", password = "", name = "";
  RxBool userLogged = false.obs;
  LocalStorage storage = LocalStorage();
  User? _user;

  User? get user => _user;

  final AuthService authService = AuthService();

  loginUser2() async {
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

    } else {
      print(response.reasonPhrase);
    }
  }

  Future<User?> getUser() async {
    try {
      User user = await authService.getUserApi();
      _user = user;
    } catch (e) {
      print(e);
    }
    update();

    return _user;
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    var checkLogin = storage.readToken();
    if (checkLogin != null) {
      userLogged.value = true;
      print("User Logged : ${userLogged.value}");
      await getUser();

      update();
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  // TODO: implement onDelete
  get onDelete => super.onDelete;
}
