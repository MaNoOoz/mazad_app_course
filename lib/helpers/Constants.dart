

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazad_app/helpers/size_config.dart';

const BaseUrl = "http://172.30.128.1:1111";

// const BaseUrl = "http://localhost:1111";
const AuthUrlRegister = "/auth/local/register";

const Map<String, String> headersNoAuth = {
  'Content-Type': 'application/json',
  "Accept": "application/json",
  "Access-Control_Allow_Origin": "*"
};

const kPrimaryColor = Color(0xFF0473C0);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);
final headingStyleBlack = GoogleFonts.cairo(
  textStyle: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    height: 1.5,
  ),
);
final headingStyleWhite = GoogleFonts.almarai(
  textStyle: TextStyle(
    color: kPrimaryLightColor,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  ),
);

final titlesStyle = GoogleFonts.cairo(
  textStyle: TextStyle(
    color: Colors.red,
    fontSize: 10,
    fontWeight: FontWeight.bold,
  ),
);
final titlesStyleBlack = GoogleFonts.cairo(
  textStyle: TextStyle(
    color: Colors.black54,
    fontSize: 14,
    fontWeight: FontWeight.normal,
  ),
);
final titlesStyleWhite = GoogleFonts.cairo(
  textStyle: TextStyle(
    color: kSecondaryColor,
    fontSize: 14,
    fontWeight: FontWeight.normal,
  ),
);
final lableStyleBlack = GoogleFonts.cairo(
  textStyle: TextStyle(
    color: Colors.black54,
    fontSize: 12,
    fontWeight: FontWeight.normal,
  ),
);
final lableStylePrimary = GoogleFonts.cairo(
  textStyle: TextStyle(
    color: kPrimaryColor,
    fontSize: 12,
    fontWeight: FontWeight.normal,
  ),
);
final ulableStylePrimary = GoogleFonts.cairo(
  textStyle: TextStyle(
    color: Colors.black38,
    fontSize: 12,
    fontWeight: FontWeight.normal,
  ),
);
const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}
