import 'package:flutter/material.dart';

class DashBoardViewModel with ChangeNotifier {
  DateTime selectedMonth = DateTime.now();

  void changeMonth(DateTime month) {
    selectedMonth = month;
    notifyListeners();
  }
}
