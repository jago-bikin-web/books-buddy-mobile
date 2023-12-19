import 'package:flutter/foundation.dart';

class PageProvider extends ChangeNotifier {
  int page = 0;

  void setPage(int value) {
    page = value;
    notifyListeners();
  }
}
