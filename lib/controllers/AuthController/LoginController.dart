import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:mazad_app/Bindings/Routers.dart';
import 'package:mazad_app/data/LocalStorage.dart';
import 'package:mazad_app/models/Ad.dart';
import 'package:mazad_app/services/AuthService.dart';

class LoginController extends GetxController {
  String identifier = "", password = "", name = "";
  RxBool userLogged = false.obs;
  LocalStorage storage = LocalStorage();
  User? _user;

  User? get user => _user;

  final AuthService authService = AuthService();

  signInUser() async {
    var ok = await authService.userLogin(identifier, password);
    if (ok) {
      Get.offAndToNamed(Routers.initialRoute);
    } else {
      Get.snackbar(
        'Somthing Wrong',
        'Make Sure Login Info Is Correct',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
    update();
  }

  Future<User?> getUser() async {
    try {
      User user = await authService.getUserApi();
      _user = user;
    } catch (e) {
      Logger().d(e);
    }
    update();

    return _user;
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();


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
