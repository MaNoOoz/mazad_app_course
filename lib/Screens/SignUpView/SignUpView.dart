import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
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
                height: 10,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextFormFieldText(
                textInputType: TextInputType.name,
                hintText: 'الإسم',
                // initialValue: 'الإسم',
                onSaved: (value) {
                  SignUpContoller.to.name = value!;
                },
                onTap: () {
                  _formKey.currentState!.save();
                  if (controller.name.isNotEmpty) print(controller.name);

                  if (controller.name.isEmpty) printError(info: "NO TEXT");
                },
                hintTextStyle:
                    fontStyle.copyWith(color: Colors.black45, fontSize: 14),
                labelTextStyle:
                    fontStyle.copyWith(color: Colors.black, fontSize: 14),
                validator: (value) {
                  if (value!.isEmpty) {
                    Logger().d("isEmpty");
                  }
                },
                labelText: 'الإسم',
              ),
              SizedBox(
                height: 20,
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
                    Logger().d("ERROR");
                  }
                },onTap: () {
                _formKey.currentState!.save();
                if (controller.email.isNotEmpty) print(controller.email);

                if (controller.email.isEmpty) printError(info: "NO TEXT");
              },
                hintTextStyle:
                    fontStyle.copyWith(color: Colors.black45, fontSize: 14),
                labelTextStyle:
                    fontStyle.copyWith(color: Colors.black, fontSize: 14),
                labelText: 'إيميل',
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextFormFieldText(
                textInputType: TextInputType.visiblePassword,
                hintText: 'كلمة السر',
                // initialValue: 'yaman@gmail.com',
                onSaved: (value) {
                  controller.password = value!;
                },
                validator: (value) {
                  if (value == null) {
                    Logger().d("ERROR");
                  }
                },onTap: () {
                _formKey.currentState!.save();
                if (controller.password.isNotEmpty) print(controller.password);

                if (controller.password.isEmpty) printError(info: "NO TEXT");
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
                    Get.put<SignUpContoller>(SignUpContoller());

                    await controller.createNewUser2();
                  }
                },
                child: Text(
                  'تسجيل',
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
                  Logger().d(storedToken);
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
              GestureDetector(
                onTap: () {
                  Get.to(LoginView());
                },
                child: Center(
                  child: Text(
                    " لديك حساب ؟",
                    style:
                        fontStyle.copyWith(color: kPrimaryColor, fontSize: 20),
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
