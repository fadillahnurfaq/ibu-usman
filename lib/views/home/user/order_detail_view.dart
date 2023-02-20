import 'package:flutter/material.dart';
import 'package:ibu_usman/controllers/home/user/order_detail_controller.dart';
import 'package:ibu_usman/shared/utils/currency_format.dart';
import 'package:ibu_usman/shared/utils/style/assets.dart';
import 'package:ibu_usman/shared/utils/style/border_radius.dart';
import 'package:ibu_usman/shared/utils/style/size.dart';
import 'package:ibu_usman/shared/utils/utility/aes_encryption.dart';
import 'package:ibu_usman/shared/widgets/button/primary_appbar.dart';
import 'package:ibu_usman/views/home/widgets/info_cart.dart';
import 'package:ibu_usman/views/home/widgets/order_card.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../shared/utils/state_util.dart';
import '../../../shared/utils/style/color.dart';
import '../../../shared/utils/style/font_weight.dart';

class OrderDetailView extends StatelessWidget {
  final Map<String, dynamic> history;
  final bool isAdmin;
  final bool isPosAdmin;
  const OrderDetailView({
    super.key,
    required this.history,
    this.isAdmin = false,
    this.isPosAdmin = true,
  });

  @override
  Widget build(BuildContext context) {
    List listData = history["products"];
    AESEncryption aesEncryption = AESEncryption();

    return Scaffold(
      body: SingleChildScrollView(
        padding: primaryPadding,
        child: Column(
          children: [
            const SizedBox(
              height: 30.0,
            ),
            PrimaryAppBar(
              onPressed: () {
                Get.back();
              },
            ),
            const SizedBox(
              height: 12.0,
            ),
            Container(
              decoration:
                  BoxDecoration(color: cardColor, borderRadius: radiusPrimary),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    isPosAdmin
                        ? "Tunjukan QR Code ke Pembeli"
                        : isAdmin
                            ? "Pesanan ${history["user"]["name"]}"
                            : history["status"] == "Dalam Proses"
                                ? "Tunjukkan QR Code Ke Kasir"
                                : history["status"] == "Ditolak"
                                    ? "Status pesanan kamu"
                                    : "Pesanan kamu sudah selesai",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: semibold,
                      color: secondaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    isAdmin || history["status"] == "Ditolak"
                        ? history["status"]
                        : history["status"] == "Dalam Proses"
                            ? "Menunggu Konfirmasi"
                            : "Terimakasih",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: extrabold,
                      color: history["status"] == "Ditolak"
                          ? Colors.red
                          : yellowColor,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  history["status"] == "Dalam Proses"
                      ? Container(
                          padding:
                              const EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 20.0),
                          child: QrImage(
                            data: aesEncryption.encryptMsg(history["id"]),
                            foregroundColor: secondaryColor,
                          ),
                        )
                      : Image.asset(
                          history["status"] == "Ditolak"
                              ? Assets.orderProcess()
                              : Assets.orderSuccess(),
                          width: Get.width,
                        ),
                ],
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Material(
              color: cardColor,
              borderRadius: radiusPrimary,
              clipBehavior: Clip.antiAlias,
              child: ValueListenableBuilder<bool>(
                valueListenable: OrderDetailController.showTrash,
                builder: (_, showTrash, __) {
                  return InkWell(
                    onTap: () {
                      OrderDetailController.handleShowTrash();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                isAdmin || isPosAdmin
                                    ? "Daftar Pesanan"
                                    : "Daftar pesanan kamu",
                                style: TextStyle(
                                  fontWeight: semibold,
                                  color: lightColor,
                                  fontSize: 16.0,
                                ),
                              ),
                              Icon(
                                showTrash
                                    ? Icons.expand_less
                                    : Icons.expand_more,
                                color: yellowColor,
                              ),
                            ],
                          ),
                          SingleChildScrollView(
                            child: AnimatedCrossFade(
                              firstChild: const SizedBox(),
                              crossFadeState: showTrash
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                              duration: const Duration(milliseconds: 500),
                              secondChild: Column(
                                children: listData
                                    .map((e) => OrderCard(product: e))
                                    .toList(),
                              ),
                            ),
                          ),
                          Divider(
                            color: strokeColor,
                            height: 32.0,
                          ),
                          InfoCart(
                              label: "Total Pesanan",
                              value: "${history["quantity"]}"),
                          InfoCart(
                            label: "Total Harga",
                            value: CurrencyFormat.convertToIdr(
                                history["total_price"], 2),
                          ),
                          InfoCart(
                            label: "Poin digunakan",
                            value:
                                "-${CurrencyFormat.convertToIdr(history["point_used"], 2)}",
                          ),
                          InfoCart(
                            label: "Total Bayar (${history["payment_method"]})",
                            value: CurrencyFormat.convertToIdr(
                                history["total_payment"], 2),
                            isTotal: true,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}
