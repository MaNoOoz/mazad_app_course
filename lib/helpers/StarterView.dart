import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mazad_app/Bindings/Widgets/BottomNavBar.dart';
import 'package:mazad_app/Screens/HomeView/HomeView.dart';
import 'package:mazad_app/controllers/AuthController/LoginController.dart';
import 'package:mazad_app/controllers/NavController/NavController.dart';
import 'package:mazad_app/data/LocalStorage.dart';
import 'package:mazad_app/widgets/side_drawer.dart';

import 'Constants.dart';

class buildSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Center(
          child: TextField(
            decoration: InputDecoration(
              hintText: "بحث",
              hintStyle:
                  fontStyle.copyWith(color: Colors.black54, fontSize: 16),
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black54,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StarterView extends StatelessWidget {
  final LocalStorage storage = LocalStorage();

  Widget baseView() {
    return GetBuilder<NavController>(
      builder: (navController) {
        return Scaffold(
          drawer: SideDrawer(),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(130),
            child: Container(
              color: Colors.blue,
              child: Column(
                children: [
                  AppBar(
                    centerTitle: true,
                    title: Text(
                      "مزاد",
                      style:
                          fontStyle.copyWith(color: Colors.white, fontSize: 22),
                    ),
                  ),
                  buildSearch(),
                ],
              ),
            ),
          ),
          body: SafeArea(
            child: IndexedStack(
              index: navController.tapValue,
              children: [
                HomeView(),
                // StoreView(),
                // ProfileView(),
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
    // return isUserThere ? LoginView() : baseView();
    return baseView();
    //
    // return baseView();
  }
}
