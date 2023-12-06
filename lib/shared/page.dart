import 'package:flutter/foundation.dart';

class PageProvider extends ChangeNotifier {
  int _page = 0;

  int get page => _page;

  void setPage(int value) {
    _page = value;
    notifyListeners();
  }
}
