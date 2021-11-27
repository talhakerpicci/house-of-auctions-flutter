import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AppProvider extends ChangeNotifier {
  int pageIndex = 0;
  void changePageIndex({required int index}) {
    pageIndex = index;
    notifyListeners();
  }
}
