import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mazad_app/Bindings/Widgets/BottomNavBar.dart';
import 'package:mazad_app/Screens/HomeView/HomeView.dart';
import 'package:mazad_app/Screens/LoginView/LoginView.dart';
import 'package:mazad_app/Screens/NewAd/AddNewAd.dart';
import 'package:mazad_app/Screens/ProfileView/ProfileView.dart';
import 'package:mazad_app/controllers/AuthController/LoginController.dart';
import 'package:mazad_app/controllers/HomeController/HomeController.dart';
import 'package:mazad_app/controllers/NavController/NavController.dart';
import 'package:mazad_app/data/LocalStorage.dart';

import 'Constants.dart';

class StarterView extends GetView<LoginController> {
  LocalStorage storage = LocalStorage();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var isLogged = controller.userLogged.value == false;
      return isLogged
          ? LoginView()
          : GetBuilder<NavController>(builder: (controller) {
              return Scaffold(
                appBar: AppBar(
                  leading: Icon(Icons.home),
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
                        onPressed: () {
                          storage
                              .deleteToken()
                              .then((value) => Get.to(() => LoginView()));
                        },
                        icon: Icon(Icons.ac_unit)),
                    IconButton(
                      onPressed: () async {
                        // return Get.to(AddAdView());
                        final HomeViewController c = Get.put(HomeViewController());
                        await c.getCategoryList();
                      },
                      icon: Icon(Icons.add),
                      tooltip: "Add Ad",
                    ),
                  ],
                ),
                body: SafeArea(
                  child: IndexedStack(
                    index: controller.tapValue,
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
    });
  }
}
