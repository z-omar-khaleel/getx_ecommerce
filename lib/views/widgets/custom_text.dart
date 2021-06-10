import 'package:ecommerce_getx/utils/constant/constant.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final Alignment alignment;
  final String txt;
  final Color color;
  final double fontsize;
  final FontWeight fontWeight;

  CustomText(
      {this.alignment = Alignment.topLeft,
      required this.txt,
      this.color = primartColor,
      this.fontsize = 20,
      this.fontWeight = FontWeight.w600});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(
        txt,
        style:
            TextStyle(color: color, fontSize: fontsize, fontWeight: fontWeight),
      ),
    );
  }
}
