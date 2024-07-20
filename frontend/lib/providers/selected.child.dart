import 'package:flutter/cupertino.dart';

import '../models/child.dart';

class SelectedChildProvider with ChangeNotifier {
  String? _selectedChildId;

  String? get selectedChildId => _selectedChildId;

  void selectChild(String childId) {
    _selectedChildId = childId;
    notifyListeners();
  }

  void clearSelection() {
    _selectedChildId = null;
    notifyListeners();
  }
}