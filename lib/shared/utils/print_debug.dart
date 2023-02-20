import 'package:flutter/foundation.dart';

class PrintDebug {
  static void printDebug(value) {
    if (kDebugMode) {
      print(value);
    }
  }
}
