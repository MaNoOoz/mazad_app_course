import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mazad_app/Screens/LoginView/LoginView.dart';
import 'package:mazad_app/controllers/AuthController/SignUpController.dart';
import 'package:mazad_app/data/LocalStorage.dart';
import 'package:mazad_app/helpers/Constants.dart';

import 'package:mazad_app/widgets/custom_text_form_field.dart';

class SignUpView extends GetView<SignUpContoller> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LocalStorage storage = LocalStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "مستخدم جديد",
          style: fontStyle.copyWith(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        elevation: 0.0,
        leading: GestureDetector(
            onTap: () {
              Get.off(LoginView());
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(LoginView());
                },
                child: Text(
                  " لديك حساب ؟",
                  style: fontStyle.copyWith(color: kPrimaryColor, fontSize: 20),
                  textDirection: TextDirection.rtl,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              CustomTextFormFieldText(
                textInputType: TextInputType.emailAddress,
                hintText: 'الإسم',
                // initialValue: 'الإسم',
                onSaved: (value) {
                  controller.email = value!;
                },
                hintTextStyle:
                    fontStyle.copyWith(color: Colors.black45, fontSize: 14),
                labelTextStyle:
                    fontStyle.copyWith(color: Colors.black, fontSize: 14),
                validator: (value) {
                  if (value == null) {
                    print("ERROR");
                  }
                },
                labelText: 'الإسم',
              ),
              SizedBox(
                height: 30,
              ),
              CustomTextFormFieldText(
                textInputType: TextInputType.emailAddress,
                hintText: 'إيميل',
                // initialValue: 'yaman@gmail.com',
                onSaved: (value) {
                  controller.email = value!;
                },
                validator: (value) {
                  if (value == null) {
                    print("ERROR");
                  }
                },
                hintTextStyle:
                    fontStyle.copyWith(color: Colors.black45, fontSize: 14),
                labelTextStyle:
                    fontStyle.copyWith(color: Colors.black, fontSize: 14),
                labelText: 'إيميل',
              ),
              SizedBox(
                height: 40,
              ),
              CustomTextFormFieldText(
                textInputType: TextInputType.emailAddress,
                hintText: 'كلمة السر',
                // initialValue: 'yaman@gmail.com',
                onSaved: (value) {
                  controller.email = value!;
                },
                validator: (value) {
                  if (value == null) {
                    print("ERROR");
                  }
                },
                hintTextStyle:
                    fontStyle.copyWith(color: Colors.black45, fontSize: 14),
                labelTextStyle:
                    fontStyle.copyWith(color: Colors.black, fontSize: 14),
                labelText: 'كلمة السر',
              ),
              SizedBox(
                height: 15,
              ),
              MaterialButton(
                onPressed: () async {
                  _formKey.currentState!.save();

                  if (_formKey.currentState!.validate()) {
                    await controller.createNewUser();
                  }
                },
                child: Text(
                  'مستخدم جديد',
                  style: fontStyle.copyWith(color: Colors.white),
                ),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                color: kPrimaryColor,
              ),
              MaterialButton(
                onPressed: () async {
                  var storedToken = await storage.readToken();
                  print(storedToken);
                },
                child: Text(
                  'Read Token',
                  style: fontStyle.copyWith(color: Colors.white),
                ),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                color: kPrimaryColor,
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
