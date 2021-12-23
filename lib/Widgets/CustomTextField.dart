import 'package:arabic_screen/Utils/Responsive.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  Responsive responsive = Responsive();
  IconData? suffixIcon;
  double? iconSize;
  Color? iconColor;
  double? textFieldHeight;
  double? borderRadius;
  double? padding;
  bool? obScure;
  bool? readOnly;
  TextEditingController? controller;
  final validation;

  CustomTextField({
    this.suffixIcon,
    this.iconSize,
    this.iconColor,
    this.textFieldHeight,
    this.borderRadius,
    this.obScure,
    this.controller,
    this.validation,
    this.padding,
    this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return TextFormField(
      validator: validation,
      controller: controller,
      readOnly: readOnly ?? false,
      textDirection: TextDirection.ltr,
      cursorColor: Color(0xFF549F5F),
      obscureText: obScure ?? false,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        suffixIcon: suffixIcon != null
            ? Icon(
                suffixIcon,
                size: iconSize,
                color: iconColor,
              )
            : null,
        border: OutlineInputBorder(
          gapPadding: 100,
        ),
        enabledBorder: OutlineInputBorder(
          gapPadding: 100,
          borderSide: BorderSide(
            color: Color(0xFFD8D5D5),
          ),
          borderRadius: BorderRadius.circular(borderRadius ?? 5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFD8D5D5),
          ),
          borderRadius: BorderRadius.circular(borderRadius ?? 5),
        ),
      ),
    );
  }
}
