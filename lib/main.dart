import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:mazad_app/controllers/ProfileController/ProfileController.dart';

import 'Bindings/Bindings.dart';
import 'Bindings/pages.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  InitialBinding().dependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      onInit: fetchAll(),
      smartManagement: SmartManagement.full,
      debugShowCheckedModeBanner: false,
      getPages: Pages.getPages,
      defaultTransition: Transition.fadeIn,
      initialBinding: InitialBinding(),
      // home: StarterView(),
    );
  }

  fetchAll() {
    Get.put<ProfileController>(ProfileController());
    Logger().d("fetchAll");
  }
}
