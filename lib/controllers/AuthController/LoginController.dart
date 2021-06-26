import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:mazad_app/Bindings/Routers.dart';
import 'package:mazad_app/data/LocalStorage.dart';
import 'package:mazad_app/models/Ad.dart';
import 'package:mazad_app/services/AuthService.dart';
import 'package:mazad_app/utils/app_state.dart';

class LoginController extends GetxController {
  String identifier = "", password = "", name = "";
  RxBool userLogged = false.obs;
  LocalStorage storage = LocalStorage();
  User? _user;

  final appState = Rx<AppState>(AppState.IDLE);

  User? get user => _user;

   final AuthService authService = AuthService() ;

  signInUser() async {
    appState.value = AppState.LOADING;

    _user = await authService.userLogin(identifier, password);
    if (_user != null) {
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
    appState.value = AppState.DONE;
  }

  Future signOutUser() async {
    appState.value = AppState.LOADING;

    await authService.signOutUser();

    // Get.offAndToNamed(Routers.initialRoute);
    Logger().d("signOutUser called");

    update();
    // Get.offAndToNamed(Routers.initialRoute);

    appState.value = AppState.DONE;
  }

  Future<User?> getLoggedInUserObject() async {
    try {
      _user = await authService.getMe();
      // _user = user;
    } catch (e) {
      Logger().d(e.toString());
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
