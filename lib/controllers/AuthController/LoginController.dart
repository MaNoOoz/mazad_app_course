import 'dart:convert';

import 'package:get/get.dart';
import 'package:mazad_app/Screens/HomeView/HomeView.dart';
import 'package:mazad_app/Screens/LoginView/LoginView.dart';
import 'package:mazad_app/data/LocalStorage.dart';
import 'package:mazad_app/helpers/Constants.dart';
import 'package:http/http.dart' as http;
import 'package:mazad_app/helpers/StarterView.dart';
import 'package:mazad_app/models/User.dart';
import 'package:mazad_app/services/AuthService.dart';

class LoginController extends GetxController {
  String email = "", password = "", name = "";

  RxBool userLogged = false.obs;

  LocalStorage storage = LocalStorage();

  late User _user;

  User get user => _user;
  final AuthService authService = AuthService();

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
      storage.saveToken("jwt", jwtToken);
      print(" Token From Login : $jwtToken");

      Get.to(() => StarterView());
    }
  }

  Future<User> getUser() async {
    try {
      User user = await authService.getUserApi();
      _user = user;
    } catch (e) {
      print(e);
    }
    // update();

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
      update();
    }
    await getUser();

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
