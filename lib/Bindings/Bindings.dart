import 'package:get/get.dart';
import 'package:mazad_app/Screens/HomeView/HomeView.dart';
import 'package:mazad_app/Screens/LoginView/LoginView.dart';
import 'package:mazad_app/controllers/AuthController/LoginController.dart';
import 'package:mazad_app/controllers/AuthController/SignUpController.dart';
import 'package:mazad_app/controllers/HomeController/HomeController.dart';
import 'package:mazad_app/controllers/NavController/NavController.dart';
import 'package:mazad_app/controllers/ProfileController/ProfileController.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => NavController());
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => SignUpContoller());
    Get.lazyPut(() => HomeViewController());
    Get.lazyPut(() => HomeView());
    Get.lazyPut(() => LoginView());
  }
}
