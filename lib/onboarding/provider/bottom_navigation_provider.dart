import 'package:flutter/widgets.dart';

class BottomNavigationProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
