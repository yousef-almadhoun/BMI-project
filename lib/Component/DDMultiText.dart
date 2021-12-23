import 'package:flutter/material.dart';
import '../Component/DDText.dart';
import '../Utils/ColorConfig.dart';

class DDMultiText extends StatelessWidget {
  final String text1, text2;
  final Color? color1, color2;
  final String? family;
  final double? size1, size2;
  final double? height;

  DDMultiText({
    this.color1,
    this.size1,
    this.family,
    this.height,
    this.color2,
    this.size2,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: text1,
          style: textStyle.copyWith(
              fontFamily: family ?? "Poppins",
              height: height ?? 1,
              fontSize: size1 ?? 14,
              color: color1 ?? ColorConfig().terColor),
          children: [
            TextSpan(
              text: text2,
              style: textStyle.copyWith(
                  fontFamily: family ?? "Poppins",
                  fontSize: size2 ?? 14,
                  height: height ?? 1,
                  color: color2 ?? ColorConfig().secondaryColor),
            )
          ]),
    );
  }
}
