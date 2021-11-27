import 'dart:math';
import 'package:flutter/material.dart';

class AppColors {
  static const Color lightGrey = Color(0xFFF3F5F6);
  static const Color lightGrey2 = Color(0xFFededed);
  static const Color darkGrey = Color(0xFF494949);
  static const Color blue = Color(0xFF29b2ff);
  static const Color green = Color(0xFF40DBA3);
  static const Color red = Color(0xFFE4756D);
  static const Color orange = Color(0xFFE5A071);
  static const Color yellow = Color(0xFFF3C932);

  static const List<Color> all = [
    AppColors.blue,
    AppColors.red,
    AppColors.green,
    AppColors.yellow,
    AppColors.orange,
    AppColors.darkGrey,
  ];

  static Color getRandomColor() {
    final randomIndex = Random().nextInt(all.length);
    return all[randomIndex];
  }
}
