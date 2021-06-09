import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mazad_app/Screens/HomeView/HomeView.dart';
import 'package:mazad_app/Screens/SignUpView/SignUpView.dart';
import 'package:mazad_app/controllers/AuthController/LoginController.dart';
import 'package:mazad_app/helpers/Constants.dart';
import 'package:mazad_app/helpers/StarterView.dart';

import 'package:mazad_app/widgets/custom_text_form_field.dart';

class LoginView extends GetView<LoginController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: Text(
          " الدخول",
          style: headingStyleWhite,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "مرحبا",
                    style: headingStyleBlack2,
                  ),
                  GestureDetector(
                    onTap: () async{
                      Get.to(() => SignUpView(),
                          fullscreenDialog: true,
                          transition: Transition.zoom,
                          duration: Duration(microseconds: 4000),
                          curve: Curves.bounceIn);
                    },
                    child: Text(
                      "تسجيل",
                      style: headingStylePrimary,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 30,
              ),
              CustomTextFormFieldText(
                text: 'إيميل',
                hint: 'yaman@gmail.com',
                onSave: (value) {
                  controller.email = value;
                },
                validator: (value) {
                  if (value == null) {
                    print("ERROR");
                  }
                },
              ),
              SizedBox(
                height: 40,
              ),
              CustomTextFormFieldPassword(
                text: 'كلمة السر',
                hint: '123123',
                onSave: (value) {
                  controller.password = value;
                },
                validator: (value) {
                  if (value == null) {
                    print('error');
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'نسيت كلمة السر',
                style: titlesStyleBlack,
              ),
              SizedBox(
                height: 15,
              ),
              MaterialButton(
                child: Text(
                  'دخول',
                  style: headingStyleWhite,
                ),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                color: kPrimaryColor,
                onPressed: () async {
                  _formKey.currentState!.save();

                  if (_formKey.currentState!.validate()) {
                    var a = await controller.loginUser();
                    print(" loginUser Pressed login value is  : $a");
                    if(a == true){
                      Get.to(()=>StarterView());
                    }else{
                      print(" somthing wrong  : $a");

                    }

                  }
                },
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
