import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const BaseUrl = "http://172.27.128.1:1111";

// const BaseUrl = "http://localhost:1111";
const AuthUrlRegister = "/auth/local/register";

const Map<String, String> headersNoAuth = {
  'Content-Type': 'application/json',
  "Accept": "application/json",
  "Access-Control_Allow_Origin": "*"
};

const kPrimaryColor = Color(0xFF0473C0);
const kPrimaryColorShadow = Color(0xFF7B94B1);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final fontStyle = GoogleFonts.almarai(
  textStyle: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.normal,
    color: Colors.black87,
    height: 1.5,
  ),
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

final otpInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 15),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular((15)),
    borderSide: BorderSide(color: kTextColor),
  );
}
