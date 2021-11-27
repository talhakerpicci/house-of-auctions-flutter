import 'package:flutter/material.dart';
import 'package:house_of_auctions/infrastructure/core/constants/colors.dart';

class Gradients {
  static const List<Color> blue = [AppColors.blue, Color(0xFF78CFFF)];
  static const List<Color> green = [AppColors.green, Color(0xFF54DFAD)];
  static const List<Color> grey = [Color(0xFFB8C4CB), Color(0xFFACB8BC)];
  static const List<Color> orange = [AppColors.orange, Color(0xFFE8AA80)];
  static const List<Color> red = [Color(0xFFED6E76), Color(0xFFEC816A)];
  static const List<Color> yellow = [Color(0xFFF3BF32), Color(0xFFF5C850)];

  static LinearGradient getDefaultGradient(List<Color> colors, {double opacity = 1}) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: Gradients.opacity(opacity, colors),
    );
  }

  static List<Color> opacity(double opacity, List<Color>? colors) {
    return colors!.map((c) => c.withOpacity(opacity)).toList();
  }

  static Map<Color, List<Color>> colorToGradient = {
    AppColors.blue: blue,
    AppColors.darkGrey: [AppColors.darkGrey, AppColors.darkGrey],
    AppColors.green: green,
    AppColors.lightGrey: grey,
    AppColors.orange: orange,
    AppColors.red: red,
    AppColors.yellow: yellow,
  };
}
