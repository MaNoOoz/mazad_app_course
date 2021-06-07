

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const BaseUrl = "http://172.20.176.1:1111";

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
TextStyle textStyleSearch = GoogleFonts.cairo(
  textStyle: TextStyle(
    color: Colors.black54,
    fontSize: 14,
    fontWeight: FontWeight.normal,
  ),
);
final headingStyle = TextStyle(
  fontWeight: FontWeight.normal,
  color: Colors.black,
  height: 1.5,
);
final headingStyleBlack = GoogleFonts.cairo(
  textStyle: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.normal,
    color: Colors.black,
    height: 1.5,
  ),
);
final headingStylePrimary = GoogleFonts.cairo(
  textStyle: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.normal,
    color:kPrimaryColor,
    height: 1.5,
  ),
);
final headingStyleWhite = GoogleFonts.almarai(
  textStyle: TextStyle(
    color: kPrimaryLightColor,
    fontSize: 24,
    fontWeight: FontWeight.normal,
  ),
);

final titlesStyle = GoogleFonts.cairo(
  textStyle: TextStyle(
    color: Colors.red,
    fontSize: 10,
    fontWeight: FontWeight.normal,
  ),
);
final titlesStyleBlack = GoogleFonts.cairo(
  textStyle: TextStyle(
    color: Colors.black54,
    fontSize: 14,
    fontWeight: FontWeight.normal,
  ),
);
final titlesStyleBlack80 = GoogleFonts.cairo(
  textStyle: TextStyle(
    color: Colors.black87,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  ),
);
final titlesStyleWhite = GoogleFonts.cairo(
  textStyle: TextStyle(
    color: kPrimaryLightColor,
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
final contentStyleBlack = GoogleFonts.cairo(
  textStyle: TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  ),
);
final contentStylWhite = GoogleFonts.cairo(
  textStyle: TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  ),
);
final contentStyleBlackBold = GoogleFonts.cairo(
  textStyle: TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontWeight: FontWeight.bold,
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
      EdgeInsets.symmetric(vertical: 15),
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
