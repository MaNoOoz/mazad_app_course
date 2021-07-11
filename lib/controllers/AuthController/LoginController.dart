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
   GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

  var isPreesed = false.obs;
  final appState = Rx<AppState>(AppState.IDLE);

  User? get user => _user;

  final AuthService authService = AuthService();

  signInUser() async {
    Logger().d("signInUser called");

    appState.value = AppState.LOADING;
    isPreesed.value = true;

    _user = await authService.userLogin(identifier, password);
    await Future.delayed(Duration(seconds: 3));
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
    appState.value = AppState.DONE;
    isPreesed.value = false;
    update();
  }

  Future signOutUser() async {
    appState.value = AppState.LOADING;

    await authService.signOutUser();
    await Future.delayed(Duration(seconds: 3));

    // Get.offAndToNamed(Routers.initialRoute);
    Logger().d("signOutUser called");

    update();
    // Get.offAndToNamed(Routers.initialRoute);

    appState.value = AppState.DONE;
  }

  Future<User?> getLoggedInUserObject() async {
    // try {
      Map<String, dynamic> res = await authService.getMe();
      User? user_FromJson = User.fromJson(res);

      // if (user_FromJson !=null ) {
        _user = user_FromJson;
        Logger().d("user_FromJson : ${_user!.email}");

      // } else {
      //   Logger().d("user is null");
      //   return null;
      // }
    // } catch (e) {
    //   Logger().d(e.toString());
    // }
    // // update();
    return _user;
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    Logger().d("onInit Login Controlelr called : ");
    ever(isPreesed, (_) {
      Logger().d("isPreesed called");

      return !isPreesed.value;
    });
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
