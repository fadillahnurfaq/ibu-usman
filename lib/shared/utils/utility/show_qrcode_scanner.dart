// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';

// import '../print_debug.dart';
// import '../state_util.dart';

// String? qrCode;
// showQrcodeScanner() async {
//   qrCode = null;
//   await Get.to(
//     page: const QrCodeScannerView(),
//   );
//   return qrCode;
// }

// class QrCodeScannerView extends StatefulWidget {
//   const QrCodeScannerView({Key? key}) : super(key: key);

//   @override
//   State<QrCodeScannerView> createState() => _QrCodeScannerViewState();
// }

// class _QrCodeScannerViewState extends State<QrCodeScannerView> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Mobile Scanner')),
//       body: MobileScanner(
//         allowDuplicates: false,
//         onDetect: (barcode, args) {
//           qrCode = barcode.rawValue;
//           if (qrCode != null) {
//             PrintDebug.printDebug("YOUR QR CODE is $qrCode");
//             Get.back();
//           }
//         },
//       ),
//     );
//   }
// }
