import 'package:flutter/material.dart';

class OrderDetailController extends ChangeNotifier {
  static ValueNotifier<bool> showTrash = ValueNotifier(false);

  static void handleShowTrash() {
    showTrash.value = !showTrash.value;
    showTrash.notifyListeners();
  }
}
