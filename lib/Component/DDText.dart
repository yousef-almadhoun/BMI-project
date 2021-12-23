import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Utils/ColorConfig.dart';

TextStyle textStyle = GoogleFonts.poppins(
  fontSize: 14,
  color: ColorConfig().terColor.withOpacity(0.8),
);

class DDText extends StatefulWidget {
  final String title;
  final String? family;
  final String? weight;
  final double? size;
  final double? wordSpacing;
  final double? height;
  final color;
  final toverflow;
  final bool? center;
  final int? line;
  final bool? under, cut;

  DDText({
    required this.title,
    this.size,
    this.color,
    this.weight,
    this.family,
    this.center,
    this.line,
    this.under,
    this.toverflow,
    this.cut,
    this.height,
    this.wordSpacing,
  });

  @override
  _DDTextState createState() => _DDTextState();
}

class _DDTextState extends State<DDText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.title,
      overflow:
          widget.toverflow == null ? TextOverflow.visible : widget.toverflow,
      maxLines: widget.line,
      style: TextStyle(
          height: widget.height ?? 1,
          // fontFamily: '$family',
          // fontFamily: 'TypesketchbookNoyhGeometricRegular',
          // style: GoogleFonts.signika(
          decoration: widget.under == true
              ? TextDecoration.underline
              : widget.cut == true
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
          fontFamily: widget.family ?? "Cairo",
          fontSize: widget.size,
          color: widget.color ?? Color(0xFF575454),
          wordSpacing: widget.wordSpacing,
          fontWeight: widget.weight == null
              ? FontWeight.normal
              : widget.weight == "Bold"
                  ? FontWeight.w700
                  : widget.weight == "SemiBold"
                      ? FontWeight.w600
                      : FontWeight.w400),
      textAlign: widget.center == null
          ? TextAlign.left
          : widget.center!
              ? TextAlign.center
              : TextAlign.left,
    );
  }
}
