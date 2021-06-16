import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormFieldText extends StatelessWidget {
  final String? labelText;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onChanged;
  final Function? onEditingComplete;
  final bool? obscureText;
  final TextInputType? textInputType;
  final Function(String?)? onSaved;
  final bool? autocorrect;
  final FormFieldValidator<String>? validator;
  final String? errorText;
  final String? initialValue;
  final TextEditingController? controller;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final bool? autovalidate;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final TextStyle? labelTextStyle;
  final TextInputAction? textInputAction;
  final Widget? suffix;
  final Widget? suffixIcon;

  const CustomTextFormFieldText(
      {required this.labelText,
      this.onTap,
      this.onChanged,
      this.onEditingComplete,
      this.obscureText,
      this.labelTextStyle,
      required this.textInputType,
      this.onSaved,
      this.hintTextStyle,
      this.autocorrect,
      this.validator,
      this.errorText,
      this.initialValue,
      this.controller,
      this.maxLines,
      this.inputFormatters,
      this.autovalidate,
      this.hintText,
      this.textInputAction,
      this.suffix,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        textDirection: TextDirection.rtl,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Text(
                "$labelText",
                style: labelTextStyle,
              ),
            ),
          ),
          TextFormField(
            initialValue: initialValue,
            onTap: onTap,
            onSaved: onSaved,
            onChanged: onChanged,
            validator: validator,
            keyboardType: textInputType,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: hintTextStyle,
            ),
          )
        ],
      ),
    );
  }
}
