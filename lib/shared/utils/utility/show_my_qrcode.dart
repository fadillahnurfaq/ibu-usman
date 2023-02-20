import 'package:flutter/material.dart';
import 'package:ibu_usman/shared/utils/style/assets.dart';
import 'package:ibu_usman/shared/utils/style/font_weight.dart';
import 'package:ibu_usman/shared/utils/utility/aes_encryption.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../state_util.dart';

void showMyQrCode(String label,
    {bool isTopUp = false, double nominal = 0}) async {
  AESEncryption aesEncryption = AESEncryption();
  await showDialog<void>(
    context: Get.currentContext,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              isTopUp
                  ? SizedBox(
                      width: Get.width / 1.5,
                      child: QrImage(
                        data:
                            "${aesEncryption.encryptMsg('{"point": $nominal}')}",
                      ),
                    )
                  : Image.asset(Assets.qr()),
            ],
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueGrey,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Kembali"),
          ),
        ],
      );
    },
  );
}
