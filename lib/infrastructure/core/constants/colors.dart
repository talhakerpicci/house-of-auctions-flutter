import 'dart:math';
import 'package:flutter/material.dart';

class AppColors {
  static const Color borda1 = Color(0xFFF0552C);
  static const Color borda2 = Color(0xFF55959F);
  static const Color borda3 = Color(0xFF2B444A);

  static const Color lightGrey = Color(0xFFF3F5F6);
  static const Color darkGrey = Color(0xFF494949);
  static const Color blue = Color(0xFF69C9FF);
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
