
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mazad_app/controllers/AuthController/LoginController.dart';
import 'package:mazad_app/services/AuthService.dart';
import 'package:mazad_app/widgets/custom_buttom.dart';
import 'package:mazad_app/widgets/custom_button_social.dart';
import 'package:mazad_app/widgets/custom_text.dart';
import 'package:mazad_app/widgets/custom_text_form_field.dart';

class LoginView
    extends GetWidget<LoginController>

{
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Container(child: Text("LoginView"),),
      // body: Padding(
      //   padding: const EdgeInsets.only(
      //     top: 50,
      //     right: 20,
      //     left: 20,
      //   ),
      //   child: Form(
      //     key: _formKey,
      //     child: Column(
      //       children: [
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             CustomText(
      //               text: "Welcome,",
      //               fontSize: 30, maxLine: 1,
      //             ),
      //             GestureDetector(
      //               onTap: () {
      //                 // Get.to(RegisterView());
      //               },
      //               child: CustomText(
      //                 text: "Sign Up",
      //                 color: primaryColor,
      //                 fontSize: 18, maxLine: 1,
      //               ),
      //             ),
      //           ],
      //         ),
      //         SizedBox(
      //           height: 10,
      //         ),
      //         CustomText(
      //           text: 'Sign in to Continue',
      //           fontSize: 14,
      //           color: Colors.grey, maxLine: 1,
      //         ),
      //         SizedBox(
      //           height: 30,
      //         ),
      //         CustomTextFormFieldText(
      //           text: 'Email',
      //           hint: 'yaman@gmail.com',
      //
      //
      //           onSave: (value) {
      //             controller.email = value;
      //           },
      //           validator: (value) {
      //             if (value == null) {
      //               print("ERROR");
      //             }
      //           },
      //         ),
      //         SizedBox(
      //           height: 40,
      //         ),
      //         CustomTextFormFieldPassword(
      //           text: 'Password',
      //           hint: '123123',
      //           onSave: (value) {
      //             controller.password = value;
      //           },
      //           validator: (value) {
      //             if (value == null) {
      //               print('error');
      //             }
      //           },
      //         ),
      //         SizedBox(
      //           height: 20,
      //         ),
      //         CustomText(
      //           text: 'Forgot Password?',
      //           fontSize: 14,
      //           alignment: Alignment.topRight, maxLine: 1,
      //         ),
      //         SizedBox(
      //           height: 15,
      //         ),
      //         CustomButton(
      //           onPress: () async{
      //             _formKey.currentState!.save();
      //
      //             if (_formKey.currentState!.validate()) {
      //               await controller.loginUser();
      //             }
      //           },
      //           text: 'SIGN IN',
      //         ),
      //         SizedBox(
      //           height: 40,
      //         ),
      //         CustomText(
      //           text: '-OR-',
      //           alignment: Alignment.center, maxLine: 1,
      //         ),
      //         SizedBox(
      //           height: 40,
      //         ),
      //         CustomButtonSocial(
      //           text: 'Sign In with Facebook',
      //           onPress: () {
      //             // controller.facebookSignInMethod();
      //           },
      //           imageName: 'assets/images/facebook.png',
      //         ),
      //         SizedBox(
      //           height: 40,
      //         ),
      //         CustomButtonSocial(
      //           text: 'Sign In with Google',
      //           onPress: () {
      //             // controller.googleSignInMethod();
      //           },
      //           imageName: 'assets/images/google.png',
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
