
import 'package:flutter/material.dart';

class Spoqa {
  static const spoqa = 'Spoqa';

  static const black_s40_w700 = CustomTextStyle(fontFamily: spoqa, color: Colors.black, fontSize: 40, fontWeight: FontWeight.w700);
  static const black_s14_w400 = CustomTextStyle(fontFamily: spoqa, color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400);
}

class CustomTextStyle extends TextStyle {
  const CustomTextStyle({
    required String fontFamily,
    required Color color,
    required double fontSize,
    required FontWeight fontWeight,
    int? height,
    Paint? foreground,
  }) : super(
    fontFamily: fontFamily,
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
    height: height == null ? null : height / fontSize,
    leadingDistribution: TextLeadingDistribution.even,
    foreground: foreground,
  );
}
