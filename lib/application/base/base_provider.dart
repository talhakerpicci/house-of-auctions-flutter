import 'package:flutter/material.dart';

enum ViewState { idle, loading, ready, error }

class BaseProvider extends ChangeNotifier {
  ViewState _state = ViewState.idle;

  ViewState get state => _state;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}
