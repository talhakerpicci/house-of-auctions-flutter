import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

Size getSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double getStatusBarHeight(BuildContext context) {
  return MediaQuery.of(context).padding.top;
}

double getSliverBarHeight(BuildContext context) {
  return getStatusBarHeight(context) + kToolbarHeight;
}

double getAppBarHeight() {
  return AppBar().preferredSize.height;
}

double getBottomBarHeight() {
  return kBottomNavigationBarHeight;
}

double getReducedScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height - AppBar().preferredSize.height - kBottomNavigationBarHeight;
}

TextTheme getTextTheme(BuildContext context) {
  return Theme.of(context).textTheme;
}

void unFocus() {
  WidgetsBinding.instance!.focusManager.primaryFocus?.unfocus();
}

String tr(
  BuildContext context,
  String key, {
  Map<String, String>? translationParams,
}) {
  return FlutterI18n.translate(
    context,
    key,
    translationParams: translationParams,
  );
}
