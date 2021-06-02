

import 'package:flutter/material.dart';

import 'custom_text.dart';

const primaryColor = Color.fromRGBO(0, 197, 105, 1);

class CustomButton extends StatelessWidget {
  final String text;

  final Color color;

  final Function? onPress ;

  CustomButton({
    required this.onPress,
    this.text = 'Write text ',
    this.color = primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(10),
      onPressed: onPress as void Function()?,
      color: primaryColor,
      child: CustomText(
        alignment: Alignment.center,
        text: text,
        color: Colors.white, maxLine: 1,
      ),
    );
  }
}
