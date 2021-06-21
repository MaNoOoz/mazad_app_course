import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mazad_app/Bindings/Routers.dart';
import 'package:mazad_app/Bindings/Widgets/BottomNavBar.dart';
import 'package:mazad_app/Screens/HomeView/HomeView.dart';
import 'package:mazad_app/Screens/LoginView/LoginView.dart';
import 'package:mazad_app/Screens/ProfileView/ProfileView.dart';
import 'package:mazad_app/controllers/AuthController/LoginController.dart';
import 'package:mazad_app/controllers/NavController/NavController.dart';
import 'package:mazad_app/controllers/NewAdController/NewAdController.dart';
import 'package:mazad_app/controllers/ProfileController/ProfileController.dart';
import 'package:mazad_app/data/LocalStorage.dart';

import 'Constants.dart';

class StarterView extends StatelessWidget {
  final LocalStorage storage = LocalStorage();

  Widget baseView() {
    return GetBuilder<NavController>(
      builder: (navController) {
        return Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.home),
            title: Text(
              "مزاد",
              style: fontStyle.copyWith(color: Colors.white, fontSize: 26),
            ),
            centerTitle: true,
            actions: [
              GetBuilder<LoginController>(
                  init: LoginController(),
                  builder: (c) {
                    return IconButton(
                        onPressed: () async {
                           // Get.offAllNamed(Routers.login);
                           // Get.toNamed(Routers.login);
                           // Get.offAndToNamed(Routers.login);
                           var userID = c.user!.id;
                           Get.put<ProfileController>(ProfileController()).getAdsListForUser(userID!);


                        },
                        icon: Icon(Icons.login_rounded));
                  }),
              GetBuilder<NewAdController>(
                  init: NewAdController(),
                  builder: (c) {
                    return IconButton(
                      onPressed: () async {
                        await Get.toNamed(Routers.newAd);

                        // return await Get.to(() => NewAdView());
                        // await c.getCategoryList();
                      },
                      icon: Icon(Icons.add),
                      tooltip: "Add Ad",
                    );
                  }),
              IconButton(
                  onPressed: () async {
                    await storage
                        .deleteToken()
                        // .then((value) => Get.to(() => LoginView()));
                        .then((value) => Get.offAllNamed(Routers.login));
                    // await Get.offAllNamed(Routers.login);
                  },
                  icon: Icon(Icons.ac_unit)),
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

  @override
  Widget build(BuildContext context) {
    // var isLogged = (value.user);
    // var isUserThere = Get.find<LoginController>().userLogged.value == false;
    // return isUserThere ? LoginView() : baseView();
    Get.put<LoginController>(LoginController());
    var isUserThere = Get.find<LoginController>().userLogged.value == false;
    return isUserThere ? LoginView() : baseView();
    //
    // return baseView();
  }
}
