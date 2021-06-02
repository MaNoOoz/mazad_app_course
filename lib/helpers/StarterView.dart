import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:mazad_app/Bindings/Widgets/BottomNavBar.dart';
import 'package:mazad_app/Screens/HomeView/HomeView.dart';
import 'package:mazad_app/Screens/LoginView/LoginView.dart';
import 'package:mazad_app/Screens/NewAd/AddNewAd.dart';
import 'package:mazad_app/Screens/ProfileView/ProfileView.dart';
import 'package:mazad_app/Screens/StoreView/StoreView.dart';
import 'package:mazad_app/controllers/AuthController/LoginController.dart';
import 'package:mazad_app/controllers/NavController/NavController.dart';

import 'Constants.dart';

class StarterView extends GetWidget<LoginController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "مزاد",
            style: headingStyleWhite,
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () => Get.to(LoginView()),
                icon: Icon(Icons.login_rounded)),
            IconButton(
              onPressed: () => Get.to(AddAdView()),
              icon: Icon(Icons.add),
              tooltip: "Add Ad",
            ),
          ],
        ),
        body: SafeArea(
          child: IndexedStack(
            index: controller.navigatorValue,
            children: [
              HomeView(),
              // StoreView(),
              ProfileView(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNav(),
      );
    });

    // return Obx(() {
    //   var isLogged = Get.find<LoginController>().userLogged.value == true;
    //   return isLogged
    //       ? LoginView()
    //       :
    //   GetBuilder<NavController>(builder: (controller) {
    //           return Scaffold(
    //             body: SafeArea(
    //               child: IndexedStack(
    //                 index: controller.navigatorValue,
    //                 children: [
    //                   HomeView(),
    //                   StoreView(),
    //                   ProfileView(),
    //                 ],
    //               ),
    //             ),
    //             bottomNavigationBar: BottomNav(),
    //           );
    //
    //         });
    // });
  }
}
