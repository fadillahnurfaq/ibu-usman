import 'package:flutter/material.dart';
import 'package:ibu_usman/shared/utils/utility/show_alert.dart';
import 'package:ibu_usman/shared/utils/utility/show_my_qrcode.dart';

class TopUpController extends ChangeNotifier {
  static ValueNotifier<double> nominal = ValueNotifier(0);

  static void handleNominalCard(double nominalTopUp) {
    nominal.value = nominalTopUp;
    nominal.notifyListeners();
  }

  static void confirmTopUp() async {
    if (nominal.value > 0) {
      showMyQrCode("Scan QR Code Dibawah Untuk Top Up",
          isTopUp: true, nominal: nominal.value);
    } else {
      showAlert("Oppss", "Pilih nominal terlebih dahulu!");
    }
  }
}
