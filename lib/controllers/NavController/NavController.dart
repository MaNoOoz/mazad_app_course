import 'package:get/get.dart';

class NavController extends GetxController {
  int _tapValue = 0;

  get tapValue => _tapValue;

  // Widget currentScreen = HomeView();

  void changeScreen(int selcetedTap) {
    _tapValue = selcetedTap;
    update();
  }
}
