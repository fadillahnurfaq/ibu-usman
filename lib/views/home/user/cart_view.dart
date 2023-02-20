import 'package:flutter/material.dart';
import 'package:ibu_usman/controllers/home/user/cart_controller.dart';
import 'package:ibu_usman/services/cart_service.dart';
import 'package:ibu_usman/shared/utils/currency_format.dart';
import 'package:ibu_usman/shared/utils/state_util.dart';
import 'package:ibu_usman/shared/utils/style/border_radius.dart';
import 'package:ibu_usman/shared/utils/style/color.dart';
import 'package:ibu_usman/shared/utils/style/size.dart';
import 'package:ibu_usman/shared/widgets/button/primary_button.dart';
import 'package:ibu_usman/shared/widgets/text_field/form_dropdown.dart';
import 'package:ibu_usman/views/home/widgets/cart_card.dart';
import 'package:ibu_usman/views/home/widgets/info_cart.dart';

import '../../../shared/utils/style/font_weight.dart';

class CartView extends StatelessWidget {
  const CartView({super.key, this.isAdmin = false});
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    CartController.isAdmin = isAdmin;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: primaryPadding,
        child: Column(
          children: [
            const SizedBox(
              height: 30.0,
            ),
            Row(
              children: [
                Material(
                  borderRadius: radiusPrimary,
                  color: cardColor,
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () {
                      Get.back();
                      CartService.totalQuantity();
                    },
                    child: SizedBox(
                      height: 44.0,
                      width: 44.0,
                      child: Icon(
                        Icons.chevron_left,
                        color: secondaryColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ibu Usman",
                      style: TextStyle(
                        fontWeight: medium,
                        color: secondaryColor,
                      ),
                    ),
                    Text(
                      "Pesanan kamu",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: semibold,
                        color: whiteColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            CartCard(
              isAdmin: isAdmin,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 275.0,
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(radiusPrimarySize),
          ),
          color: darkColor,
        ),
        child: ValueListenableBuilder<double>(
            valueListenable: CartController.totalPayment,
            builder: (_, totalPayment, __) {
              return ValueListenableBuilder<double>(
                  valueListenable: CartController.yourPoint,
                  builder: (_, yourPoint, __) {
                    return ValueListenableBuilder<double>(
                      valueListenable: CartService.total,
                      builder: (_, total, __) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Pembayaran",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: medium,
                                    color: secondaryColor,
                                  ),
                                ),
                                FormDropdown(
                                  width: 80,
                                  height: 50,
                                  items: const [
                                    "Cash",
                                    "Debit",
                                    "Ovo",
                                    "Dana",
                                    "Gopay"
                                  ],
                                  onChanged: (v) {
                                    CartController.paymentMethod = v;
                                  },
                                ),
                              ],
                            ),
                            ValueListenableBuilder(
                              valueListenable: CartService.quantity,
                              builder: (_, quantity, __) {
                                return InfoCart(
                                    label: "Total Pesanan", value: "$quantity");
                              },
                            ),
                            InfoCart(
                                label: "Total Harga",
                                value: CurrencyFormat.convertToIdr(total, 2)),
                            InfoCart(
                              label: "Point Digunakan",
                              value:
                                  "-${CurrencyFormat.convertToIdr(yourPoint, 2)}",
                            ),
                            InfoCart(
                              label: "Total Bayar",
                              value:
                                  CurrencyFormat.convertToIdr(totalPayment, 2),
                              isTotal: true,
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            PrimaryButton(
                              label: "Pesan Sekarang",
                              onPressed: () {
                                CartController.orderNow();
                              },
                            )
                          ],
                        );
                      },
                    );
                  });
            }),
      ),
    );
  }
}
