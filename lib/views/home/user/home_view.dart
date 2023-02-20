import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ibu_usman/controllers/home/user/home_controller.dart';
import 'package:ibu_usman/models/products_model.dart';
import 'package:ibu_usman/services/product_service.dart';
import 'package:ibu_usman/shared/utils/state_util.dart';
import 'package:ibu_usman/shared/utils/style/color.dart';
import 'package:ibu_usman/shared/utils/style/font_weight.dart';
import 'package:ibu_usman/shared/utils/style/size.dart';
import 'package:ibu_usman/shared/widgets/button/primary_button.dart';
import 'package:ibu_usman/views/home/widgets/product_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: primaryPadding,
        child: ValueListenableBuilder<int>(
            valueListenable: HomeController.currentFilter,
            builder: (_, currentFilter, __) {
              return Column(
                children: [
                  const SizedBox(
                    height: 40.0,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.pin_drop_outlined,
                        size: 24.0,
                        color: secondaryColor,
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        "Jl. Lumbu Tengah IIIF No.28",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: semibold,
                          color: secondaryColor,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Text(
                    "Silahkan nikmati hidangan yang dipilih secara khusus ini",
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: semibold,
                      color: whiteColor,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      PrimaryButton(
                        width: Get.width / 2 - heightButton - 3.0,
                        label: "Makanan",
                        backgroundButton:
                            currentFilter == 0 ? yellowColor : backgroundColor,
                        onPressed: () {
                          HomeController.handleFilter(0);
                        },
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      PrimaryButton(
                        width: Get.width / 2 - heightButton - 3.0,
                        label: "Minuman",
                        backgroundButton:
                            currentFilter == 1 ? yellowColor : backgroundColor,
                        onPressed: () {
                          HomeController.handleFilter(1);
                        },
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Container(
                        height: heightButton,
                        width: heightButton,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: cardColor,
                        ),
                        child: IconButton(
                          onPressed: () async {
                            await HomeController.scanQrCode();
                          },
                          icon: Icon(
                            Icons.qr_code_rounded,
                            color: secondaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: ProductService.getProduct(
                        type: currentFilter == 0 ? "Makanan" : "Minuman"),
                    builder: (context, s) {
                      if (s.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (s.data?.docs != null) {
                        List<ProductsModel> product = [];
                        for (var e in s.data!.docs) {
                          product.add(ProductsModel.fromJson(e.data()));
                        }
                        return Column(
                          children: product.map((e) => ProductCard(e)).toList(),
                        );
                      } else {
                        return const Center(
                          child: Text(
                            "Belum Ada Data Makanan",
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }
                    },
                  ),
                ],
              );
            }),
      ),
    );
  }
}
