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
        title: Text("مستخدم جديد",style: headingStyleWhite,),
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
        padding: const EdgeInsets.all(
            32
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                "مستخدم جديد",
                style: headingStylePrimary,
                textDirection: TextDirection.rtl,
              ),
              SizedBox(
                height: 30,
              ),
              CustomTextFormFieldText(
                text: 'الإسم',
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
                text: 'الإيميل',
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
                text: 'كلمة السر',
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
              MaterialButton(
                onPressed: () async {
                  _formKey.currentState!.save();

                  if (_formKey.currentState!.validate()) {
                    await controller.createNewUser();
                  }
                },
                child: Text(
                  'مستخدم جديد',
                  style: headingStyleWhite,
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
                  style: headingStyleWhite,
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
