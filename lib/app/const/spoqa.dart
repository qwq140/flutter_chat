
import 'package:flutter/material.dart';

class Spoqa {
  static const spoqa = 'Spoqa';

  static const black_s40_w700 = CustomTextStyle(fontFamily: spoqa, color: Colors.black, fontSize: 40, fontWeight: FontWeight.w700);
  static const black_s14_w400 = CustomTextStyle(fontFamily: spoqa, color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400);
  static const black_s10_w400 = CustomTextStyle(fontFamily: spoqa, color: Colors.black, fontSize: 10, fontWeight: FontWeight.w400);
  static const black_s18_w500 = CustomTextStyle(fontFamily: spoqa, color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500);
  
  static const grey_s14_w400 = CustomTextStyle(fontFamily: spoqa, color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w400);
  
  static const white_s14_w400 = CustomTextStyle(fontFamily: spoqa, color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400);
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
