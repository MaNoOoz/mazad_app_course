import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:mazad_app/Screens/SignUpView/SignUpView.dart';
import 'package:mazad_app/controllers/AuthController/LoginController.dart';
import 'package:mazad_app/helpers/Constants.dart';
import 'package:mazad_app/utils/app_state.dart';
import 'package:mazad_app/widgets/custom_text_form_field.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    var _formKey = controller.formKey;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: Text(
          " تسجيل الدخول",
          style: fontStyle.copyWith(color: Colors.white, fontSize: 24),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: Text(
                  "مزاد",
                  style: fontStyle.copyWith(
                      color: Colors.pink.shade200,
                      fontWeight: FontWeight.bold,
                      fontSize: 48),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              CustomTextFormFieldText(
                textInputType: TextInputType.emailAddress,
                hintText: 'إيميل',
                initialValue: 'asd@gmail.com',
                onSaved: (value) async {
                  controller.identifier = value!.trim();
                },
                onChanged: (value) {
                  controller.identifier = value.trim();
                  Logger().d("${controller.identifier}");
                },
                onTap: () {
                  Logger().d("${controller.identifier}");

                  // printInfo(info: "${controller.identifier}");
                },
                validator: (value) {
                  if (value == null) {
                    Logger().d("ERROR");
                  }
                },
                labelText: 'إيميل',
                hintTextStyle:
                    fontStyle.copyWith(color: Colors.black45, fontSize: 14),
                labelTextStyle:
                    fontStyle.copyWith(color: Colors.black, fontSize: 14),
              ),
              SizedBox(
                height: 40,
              ),
              CustomTextFormFieldText(
                textInputType: TextInputType.visiblePassword,
                hintText: 'كلمة السر',
                initialValue: 'asdasd',
                hintTextStyle:
                    fontStyle.copyWith(color: Colors.black45, fontSize: 14),
                labelTextStyle:
                    fontStyle.copyWith(color: Colors.black, fontSize: 14),
                onSaved: (value) {
                  controller.password = value!.trim();
                  Logger().d("${controller.password}");
                },
                onChanged: (value) {
                  controller.password = value.trim();
                  Logger().d("${controller.password}");
                },
                onTap: () {
                  Logger().d("${controller.password}");

                  // printInfo(info: "${controller.identifier}");
                },
                validator: (value) {
                  if (value == null) {
                    Logger().d("ERROR");
                  }
                },
                labelText: 'كلمة السر',
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'نسيت كلمة السر',
                style: fontStyle.copyWith(color: Colors.blue, fontSize: 14),
              ),
              SizedBox(
                height: 50,
              ),
              MaterialButton(
                  disabledColor: Colors.grey,
                  focusColor: Colors.red,
                  highlightColor: Colors.red,
                  hoverColor: Colors.red,
                  height: 55,
                  child: Obx(
                    () {
                      if (controller.appState() == AppState.LOADING) {
                        return Center(
                            child: CircularProgressIndicator(
                          color: Colors.white,
                        ));
                      } else {
                        // Logger().d(
                        //     "// controller.appState.value = AppState.LOADING; LIST ${controller.appState.value}");
                        // Logger().d(" ${controller.isPreesed.value.toString()}");

                        return Text(
                          'دخول',
                          style: fontStyle.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        );
                      }
                    },
                  ),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  color: kPrimaryColor,
                  // onPressed: controller.isPreesed ? () => loginUser(_formKey) : null),
                  onPressed: () async => loginUser(_formKey)),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () async {
                  Get.to(() => SignUpView(),
                      fullscreenDialog: true,
                      transition: Transition.zoom,
                      duration: Duration(microseconds: 4000),
                      curve: Curves.bounceIn);
                },
                child: Center(
                  child: Text(
                    "مستخدم جديد ؟",
                    style:
                        fontStyle.copyWith(color: kPrimaryColor, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  loginUser(_formKey) async {
    Get.put<LoginController>(LoginController());

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      await controller.signInUser();
      // await controller.loginUser2();
      // Logger().d(" loginUser Pressed login value is  : $a");

    }
  }
}
