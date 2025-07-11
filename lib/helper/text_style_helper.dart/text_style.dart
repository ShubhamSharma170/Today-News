import 'package:flutter/material.dart';
import 'package:today_news/constant/colors.dart';

class TextStyleHelper {
  static TextStyle? textStyle({
    Color? color,
    double size = 14,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return TextStyle(
      color: color ?? AllColors.black,
      fontSize: size,
      fontWeight: fontWeight,
    );
  }
}
