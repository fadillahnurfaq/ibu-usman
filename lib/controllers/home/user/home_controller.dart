import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:ibu_usman/shared/utils/utility/aes_encryption.dart';

import '../../../services/order_service.dart';
import '../../../services/point_service.dart';
import '../../../services/user_services.dart';
import '../../../shared/utils/currency_format.dart';
import '../../../shared/utils/state_util.dart';
import '../../../shared/utils/utility/show_alert.dart';
import '../../../shared/utils/utility/show_loading.dart';
import '../../../shared/utils/utility/show_succes.dart';

class HomeController {
  static ValueNotifier<int> currentFilter = ValueNotifier(0);

  static void handleFilter(int index) {
    currentFilter.value = index;
  }

  static scanQrCode() async {
    AESEncryption aesEncryption = AESEncryption();
    String barcode = await FlutterBarcodeScanner.scanBarcode(
      "#000000",
      "CANCEL",
      true,
      ScanMode.QR,
    );

    if (barcode != "-1") {
      showLoading();
      var data = aesEncryption.decryptMsg(aesEncryption.getCode(barcode));

      if (data.substring(0, 1) != "{") {
        Get.back();
        await OrderService.getOrderFromAdmin(
          id: data,
          userData: await UserService.getUserData(),
        );
        showSuccess(message: "Pesanan $barcode berhasil diselesaikan");
      } else {
        var decode = jsonDecode(data);

        if (decode["point"] > 0) {
          await PointService.addPoint(
            point: double.parse("${decode["point"] ?? 0.0}"),
            userData: await UserService.getUserData(),
          );

          Get.back();
          showSuccess(
              message:
                  "${CurrencyFormat.convertToIdr(decode['point'], 2)} Point berhasil ditambahkan!");
        } else {
          Get.back();
          showAlert("Maaf", "QR Code tidak ditemukan");
        }
      }
    }
  }
}
