import 'package:flutter/material.dart';

class AppC {
  static const n8  = Color(0xFF071A47);
  static const n7  = Color(0xFF0B2260);
  static const n6  = Color(0xFF0F2C7D);
  static const n5  = Color(0xFF1438A0);
  static const n4  = Color(0xFF2050CC);
  static const n3  = Color(0xFF4472E8);
  static const n2  = Color(0xFF87A8F5);
  static const n1  = Color(0xFFC3D3FA);
  static const n0  = Color(0xFFEEF3FF);
  static const w   = Color(0xFFFFFFFF);
  static const ow  = Color(0xFFF5F8FF);
  static const bdr = Color(0xFFD4DEF7);
  static const mut = Color(0xFF6B82C0);
  static const dan = Color(0xFFC0392B);

  static const Gradient navyGrad = LinearGradient(
    begin: Alignment.topLeft, end: Alignment.bottomRight,
    colors: [n5, n4]);

  static const Gradient darkGrad = LinearGradient(
    begin: Alignment.topLeft, end: Alignment.bottomRight,
    colors: [n8, n6]);

  static BoxDecoration cardDeco({double r = 16}) => BoxDecoration(
    color: w, borderRadius: BorderRadius.circular(r),
    boxShadow: [BoxShadow(color: n7.withOpacity(.07), blurRadius: 12, offset: const Offset(0, 3))]);

  static BoxDecoration navyDeco({double r = 16}) => BoxDecoration(
    gradient: navyGrad, borderRadius: BorderRadius.circular(r),
    boxShadow: [BoxShadow(color: n5.withOpacity(.3), blurRadius: 16, offset: const Offset(0, 6))]);
}