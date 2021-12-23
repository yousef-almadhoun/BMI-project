import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Component/DDText.dart';
import '../Utils/ColorConfig.dart';

class DDButton extends StatelessWidget {

  final double? height,width;
  final String? title;
  final Color? bgColor;
  final Function? onTap;

  DDButton({this.height,this.width,this.onTap,this.title,this.bgColor});

  final ColorConfig colors=ColorConfig();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap!();
      },
      child: Container(
        height: height??50,
        width: width??double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: bgColor??colors.secondaryColor,
          borderRadius: BorderRadius.circular(5)
        ),
        child: Center(child: DDText(title: title!,color: colors.primaryColor,weight: "Bold",size: 14,)),
      ),
    );
  }
}
