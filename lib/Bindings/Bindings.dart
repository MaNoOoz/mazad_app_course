import 'package:get/get.dart';
import 'package:mazad_app/Screens/HomeView/HomeView.dart';
import 'package:mazad_app/Screens/LoginView/LoginView.dart';
import 'package:mazad_app/controllers/AuthController/LoginController.dart';
import 'package:mazad_app/controllers/AuthController/SignUpController.dart';
import 'package:mazad_app/controllers/HomeController/HomeController.dart';
import 'package:mazad_app/controllers/NavController/NavController.dart';
import 'package:mazad_app/controllers/NewAdController/NewAdController.dart';
import 'package:mazad_app/controllers/ProfileController/ProfileController.dart';
import 'package:mazad_app/data/LocalStorage.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<LocalStorage>(() => LocalStorage());

    Get.lazyPut<NavController>(() => NavController());
    Get.lazyPut<NewAdController>(() => NewAdController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<SignUpContoller>(() => SignUpContoller());
    Get.lazyPut<HomeViewController>(() => HomeViewController());
    Get.lazyPut<HomeView>(() => HomeView());
    Get.lazyPut<LoginView>(() => LoginView());
  }
}
