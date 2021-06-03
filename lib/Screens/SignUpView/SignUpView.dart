

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mazad_app/Screens/LoginView/LoginView.dart';
import 'package:mazad_app/controllers/AuthController/SignUpController.dart';
import 'package:mazad_app/data/LocalStorage.dart';
import 'package:mazad_app/widgets/custom_buttom.dart';
import 'package:mazad_app/widgets/custom_text.dart';
import 'package:mazad_app/widgets/custom_text_form_field.dart';

class SignUpView extends GetView<SignUpContoller>{

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LocalStorage storage = LocalStorage();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: GestureDetector(
            onTap: () {
              Get.off(LoginView());
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 50,
          right: 20,
          left: 20,
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomText(
                text: "Sign Up,",
                fontSize: 30, maxLine: 1,
              ),
              SizedBox(
                height: 30,
              ),
              CustomTextFormFieldText(
                text: 'Name',
                // hint: 'yourName',
                onSave: (value) {
                  controller.name = value;
                },
                validator: (value) {
                  if (value == null) {
                    print("ERROR");
                  }
                },
              ),
              SizedBox(
                height: 30,
              ),
              CustomTextFormFieldText(
                text: 'Email',
                // hint: ' yourEmail@gmail.com',
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
              CustomTextFormFieldText(
                text: 'Password',
                // hint: '**********',
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
                height: 15,
              ),
              CustomButton(
                onPress: () async {
                  _formKey.currentState!.save();

                  if (_formKey.currentState!.validate()) {
                    await controller.createNewUser();
                  }
                },
                text: 'Create New User',
              ),
              CustomButton(
                onPress: () async {
                  // final box = GetStorage();
                  var storedToken =  await storage.readToken();

                  print(storedToken);
                },
                text: 'Read Token',
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