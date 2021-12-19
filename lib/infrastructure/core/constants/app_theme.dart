import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:house_of_auctions/infrastructure/core/constants/colors.dart';

class AppTheme {
  static final ThemeData defaultTheme = _buildTheme();

  static const defaultTextStyle = TextStyle(
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    height: 1.2,
    color: AppColors.darkGrey,
  );

  static ThemeData _buildTheme() {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shadowColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: AppColors.lightGrey,
      textTheme: TextTheme(
        headline1: defaultTextStyle.copyWith(fontSize: 24),
        headline2: defaultTextStyle.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        subtitle1: defaultTextStyle.copyWith(fontSize: 15),
        subtitle2: defaultTextStyle.copyWith(fontSize: 14),
        bodyText1: defaultTextStyle.copyWith(fontSize: 13, height: 1.4),
        bodyText2: defaultTextStyle.copyWith(fontSize: 11, height: 1.1),
        caption: defaultTextStyle.copyWith(fontSize: 9),
        button: defaultTextStyle.copyWith(fontSize: 11, height: 1.4),
      ),
    );
  }
}
