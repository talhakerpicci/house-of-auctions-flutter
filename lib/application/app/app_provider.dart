import 'package:flutter_riverpod/flutter_riverpod.dart';

final appProvider = StateNotifierProvider((ref) {
  return PageIndex();
});

class PageIndex extends StateNotifier<int> {
  PageIndex() : super(0);

  void changePageIndex(int index) {
    state = index;
  }
}
