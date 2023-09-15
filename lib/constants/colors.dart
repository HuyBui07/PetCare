import 'package:flutter/material.dart';

class AppColors {
  static const Color violet = Color(0xFF4552CB);
  static const Color lightgray = Color(0xFFF8F7FB);
  static const Color gray = Color(0xFFBBC3CE);

  static const Color lightgrey2 = Color(0xFFF0F0F8);

  static const Color green = Color(0xFF01B41F);
  static List<BoxShadow> boxShadow = [
    BoxShadow(
      color: const Color(0xff4552CB).withOpacity(0.15),
      spreadRadius: 0,
      blurRadius: 13,
      offset: Offset(0, 4),
    ),
    BoxShadow(
      color: const Color(0xff2A2049).withOpacity(0.09),
      spreadRadius: 0,
      blurRadius: 3,
      offset: Offset(0, 1),
    ),
  ];
}
