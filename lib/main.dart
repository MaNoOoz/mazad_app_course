import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mazad_app/Screens/HomeView/HomeView.dart';
import 'package:mazad_app/Screens/ProfileView/ProfileView.dart';
import 'package:mazad_app/Screens/StoreView/StoreView.dart';
import 'package:mazad_app/services/AuthService.dart';
import 'package:mazad_app/services/Home%20Service.dart';

import 'Bindings/Bindings.dart';
import 'Bindings/Widgets/BottomNavBar.dart';
import 'Screens/LoginView/LoginView.dart';
import 'helpers/StarterView.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
   Binding().dependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      getPages: [
        GetPage(name: "/", page: () => MyApp()),

      ],
      defaultTransition: Transition.fadeIn,
      initialBinding: Binding(),
      home:  StarterView(),
    );
  }
}
