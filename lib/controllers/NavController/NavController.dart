import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mazad_app/Screens/HomeView/HomeView.dart';
import 'package:mazad_app/Screens/ProfileView/ProfileView.dart';
import 'package:mazad_app/Screens/StoreView/StoreView.dart';

class NavController extends GetxController {

  int _tapValue = 0;

  get tapValue => _tapValue;

  // Widget currentScreen = HomeView();

  void changeScreen(int selcetedTap) {
    _tapValue = selcetedTap;
    update();
  }


}
