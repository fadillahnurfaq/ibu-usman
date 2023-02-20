import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../state_util.dart';
import '../style/color.dart';

void showLoading() async {
  return await showDialog<void>(
    context: Get.currentContext,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: SpinKitPouringHourGlass(
          color: whiteColor,
          duration: const Duration(milliseconds: 1200),
        ),
        content: Text(
          "Mohon tunggu...",
          style: TextStyle(fontSize: 12, color: whiteColor),
          textAlign: TextAlign.center,
        ),
      );
    },
  );
}
