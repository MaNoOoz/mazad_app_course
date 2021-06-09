import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mazad_app/helpers/Constants.dart';

class CustomTextFormFieldText extends StatelessWidget {
  final String? text;

  final String? hint;

  final Function? onSave;
  final Function? validator;

  CustomTextFormFieldText({
    this.text,
    this.hint,
    this.onSave,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        textDirection: TextDirection.rtl,
        children: [
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Text(
              "$text",
              style: titlesStyleBlack,
            ),
          ),
          TextFormField(
            controller: TextEditingController(text: 'yaman@gmail.com'),
            onSaved: onSave as void Function(String?)?,
            validator: validator as String? Function(String?)?,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.black,
              ),
              fillColor: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}

class CustomTextFormFieldPassword extends StatelessWidget {
  final String? text;

  final String? hint;

  final Function? onSave;
  final Function? validator;

  CustomTextFormFieldPassword({
    this.text,
    this.hint,
    this.onSave,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        textDirection: TextDirection.rtl,
        children: [
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Text(
              "$text",
              style: titlesStyleBlack,
            ),
          ),
          TextFormField(
            controller: TextEditingController(text: '123123'),
            onSaved: onSave as void Function(String?)?,
            validator: validator as String? Function(String?)?,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.black,
              ),
              fillColor: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
