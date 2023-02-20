import 'package:flutter/material.dart';

class MenuViewController {
  static ValueNotifier<int> currentFilter = ValueNotifier(0);

  static void handleFilter(int index) {
    currentFilter.value = index;
  }
}
