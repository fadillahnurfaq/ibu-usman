import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:ibu_usman/services/order_service.dart';
import 'package:ibu_usman/shared/utils/utility/aes_encryption.dart';
import 'package:ibu_usman/shared/utils/utility/show_alert.dart';
import 'package:ibu_usman/shared/utils/utility/show_confirmation.dart';
import 'package:ibu_usman/shared/utils/utility/show_succes.dart';
import 'package:ibu_usman/views/home/user/order_detail_view.dart';

import '../../../shared/utils/currency_format.dart';
import '../../../shared/utils/state_util.dart';
import '../../../shared/utils/style/border_radius.dart';
import '../../../shared/utils/style/color.dart';
import '../../../shared/utils/style/font_weight.dart';

class NewOrderCard extends StatelessWidget {
  const NewOrderCard({super.key, required this.item});
  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    List listOrderData = item["products"];
    AESEncryption aesEncryption = AESEncryption();

    Widget listOrder(Map<String, dynamic> itemOrder) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Text(
          '${itemOrder["quantity"]}x | ${itemOrder["name"]}',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: medium,
            color: whiteColor,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Material(
        color: warningColor,
        borderRadius: radiusPrimary,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            if (item["user"]["name"] == "Kasir") {
              Get.to(
                  page: OrderDetailView(
                history: item,
                isPosAdmin: true,
              ));
            }
          },
          child: Container(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: 4.0,
                        blurRadius: 2.0,
                        blurStyle: BlurStyle.outer,
                      ),
                    ],
                    borderRadius: radiusPrimary,
                    image: DecorationImage(
                      image: NetworkImage("${item["user"]["photo"]}"),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: Get.width - 280.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                listOrderData.map((e) => listOrder(e)).toList(),
                          )),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        "Pembeli : ${item["user"]["name"]}",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: whiteColor,
                        ),
                      ),
                      Text(
                        "${item["quantity"]} menu - total ${CurrencyFormat.convertToIdr(item["total_payment"], 2)} (${item["payment_method"]})",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
                item["user"]["name"] == "Kasir"
                    ? IconButton(
                        onPressed: () {
                          showConfirmation(
                            onPressed: () {
                              OrderService.deleteOrder("${item["id"]}");
                              showSuccess(
                                  message:
                                      "Pesanan ${item["id"]} berhasil dihapus");
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      )
                    : Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              // var qrCode = await showQrcodeScanner();
                              String barcode =
                                  await FlutterBarcodeScanner.scanBarcode(
                                "#000000",
                                "CANCEL",
                                true,
                                ScanMode.QR,
                              );
                              if (barcode != "-1") {
                                var data = aesEncryption
                                    .decryptMsg(aesEncryption.getCode(barcode));

                                if (item["id"] == data) {
                                  await OrderService.markAsDone(
                                      "${item["id"]}");
                                  showSuccess(
                                      message:
                                          "Pesanan $data berhasil diselesaikan");
                                } else {
                                  showAlert("Gagal", "Qr Code tidak sesuai");
                                }
                              }
                            },
                            icon: const Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showConfirmation(
                                onPressed: () async {
                                  await OrderService.markAsReject(
                                      "${item["id"]}");
                                  showSuccess(
                                      message:
                                          "Pesanan ${item["id"]} Behasil ditolak");
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
