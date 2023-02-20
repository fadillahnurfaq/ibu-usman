
import 'package:flutter/material.dart';

class InputTextfieldController {
  static ValueNotifier<bool> showPassword = ValueNotifier(false);

  static void changeShowPassword() {
    showPassword.value = !showPassword.value;
  }
}
