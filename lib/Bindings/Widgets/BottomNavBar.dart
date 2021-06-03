import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:mazad_app/controllers/NavController/NavController.dart';
import 'package:mazad_app/helpers/Constants.dart';

class BottomNav extends GetView<NavController> {



  Widget bottomNavBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          label: 'الرئيسية',
          icon: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Image.asset(
              'assets/icons/home.png',
              fit: BoxFit.contain,
              color: Colors.black38,
              width: 20,
            ),
          ),
        ),
        // BottomNavigationBarItem(
        //   label: 'المتجر',
        //   icon: Padding(
        //     padding: const EdgeInsets.only(top: 20),
        //     child: Image.asset(
        //       'assets/icons/store.png',
        //       fit: BoxFit.contain,
        //       width: 20,
        //       // color: Colors.black,
        //     ),
        //   ),
        // ),
        BottomNavigationBarItem(
          label: 'حسابي',
          icon: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Image.asset(
              'assets/icons/user.png',
              fit: BoxFit.contain,
              width: 20,
              color: Colors.black38,
            ),
          ),
        ),
      ],
      currentIndex: controller.tapValue,
      onTap: (index) {
        print(index);
        controller.changeScreen(index);

      },
      selectedItemColor: kPrimaryColor,
      selectedLabelStyle: lableStylePrimary,
      unselectedLabelStyle: ulableStylePrimary,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return bottomNavBar();
  }
}
