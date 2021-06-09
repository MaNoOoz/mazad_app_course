import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mazad_app/Bindings/Widgets/BottomNavBar.dart';
import 'package:mazad_app/Screens/HomeView/HomeView.dart';
import 'package:mazad_app/Screens/LoginView/LoginView.dart';
import 'package:mazad_app/Screens/ProfileView/ProfileView.dart';
import 'package:mazad_app/controllers/AuthController/LoginController.dart';
import 'package:mazad_app/controllers/HomeController/HomeController.dart';
import 'package:mazad_app/controllers/NavController/NavController.dart';
import 'package:mazad_app/data/LocalStorage.dart';

import 'Constants.dart';

class StarterView extends GetWidget<LoginController> {
  final LocalStorage storage = LocalStorage();

  @override
  Widget build(BuildContext context) {
    // var isLogged = (value.user);
    var isUserThere = Get.find<LoginController>().user == null;
    return isUserThere
        ? LoginView()
        : GetBuilder<NavController>(
            builder: (navController) {
              return Scaffold (
                appBar: AppBar(
                  leading: Icon(Icons.home),
                  title: Text(
                    "مزاد",
                    style: headingStyleWhite,
                  ),
                  centerTitle: true,
                  actions: [
                    GetBuilder<LoginController>(
                        init: LoginController(),
                        builder: (c) {
                          return IconButton(
                              onPressed: () async {
                                return Get.to(() => LoginView());
                                // LoginController a = LoginController();
                                // AuthService a = AuthService();
                                // await a.getLoggedUserId();
                                // var aa=  await a.getUserApi();
                              },
                              icon: Icon(Icons.login_rounded));
                        }),
                    IconButton(
                        onPressed: () async {
                          await storage
                              .deleteToken()
                              .then((value) => Get.offAll(() => LoginView()));
                        },
                        icon: Icon(Icons.ac_unit)),
                    IconButton(
                      onPressed: () async {
                        // return Get.to(AddAdView());
                        final HomeViewController c =
                            Get.put(HomeViewController());
                        await c.getCategoryList();
                      },
                      icon: Icon(Icons.add),
                      tooltip: "Add Ad",
                    ),
                  ],
                ),
                body: SafeArea(
                  child: IndexedStack(
                    index: navController.tapValue,
                    children: [
                      HomeView(),
                      // StoreView(),
                      ProfileView(),
                    ],
                  ),
                ),
                bottomNavigationBar: BottomNav(),
              );
            },
          );
  }
}
