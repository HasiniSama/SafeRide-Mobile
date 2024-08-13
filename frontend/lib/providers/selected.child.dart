import 'package:flutter/cupertino.dart';

import '../models/child.dart';

class SelectedChildProvider with ChangeNotifier {
  Child? _selectedChildId;

  Child? get selectedChildId => _selectedChildId;

  void selectChild(Child child) {
    _selectedChildId = child;
    notifyListeners();
  }

  void clearSelection() {
    _selectedChildId = null;
    notifyListeners();
  }
}