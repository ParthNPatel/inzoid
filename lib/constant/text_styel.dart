import 'package:flutter/material.dart';
import 'package:inzoid/constant/text_const.dart';

class CommonText {
  static textBoldWight400(
      {required String text, double? fontSize, Color? color}) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: fontSize,
          color: color,
          fontFamily: constText.fontFamily),
    );
  }

  static textBoldWight500(
      {required String text, double? fontSize, Color? color}) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: fontSize,
          color: color,
          fontFamily: constText.fontFamily),
    );
  }

  static textBoldWight700(
      {required String text, double? fontSize, Color? color}) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: fontSize,
          color: color,
          fontFamily: constText.fontFamily),
    );
  }

  ///textStyle

}
