import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../state_util.dart';
import '../style/color.dart';

Future<void> showSuccess({String? message}) async {
  await Alert(
    context: Get.currentContext,
    type: AlertType.success,
    title: message ?? "Berhasil",
    buttons: [
      DialogButton(
        color: Colors.greenAccent[700],
        child: Text(
          "Oke",
          style: TextStyle(color: secondaryColor, fontSize: 14),
        ),
        onPressed: () => Get.back(),
      )
    ],
  ).show();
}
