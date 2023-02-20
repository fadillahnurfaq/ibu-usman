import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ibu_usman/controllers/home/admin/home_admin_controller.dart';
import 'package:ibu_usman/services/firebase_auth_service.dart';
import 'package:ibu_usman/shared/utils/state_util.dart';
import 'package:ibu_usman/shared/utils/style/border_radius.dart';
import 'package:ibu_usman/shared/utils/style/color.dart';
import 'package:ibu_usman/shared/utils/style/size.dart';
import 'package:ibu_usman/shared/utils/utility/show_confirmation.dart';
import 'package:ibu_usman/shared/utils/utility/show_my_qrcode.dart';
import 'package:ibu_usman/shared/widgets/button/primary_button.dart';
import 'package:ibu_usman/views/home/admin/menu_view.dart';
import 'package:ibu_usman/views/home/admin/top_up_view.dart';
import 'package:ibu_usman/views/home/user/cart_view.dart';
import 'package:ibu_usman/views/home/widgets/menu_button.dart';
import 'package:ibu_usman/views/home/widgets/new_order_card.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../controllers/home/user/cart_controller.dart';
import '../../../models/products_model.dart';
import '../../../services/cart_service.dart';
import '../../../services/product_service.dart';
import '../../../shared/utils/style/font_weight.dart';
import '../widgets/product_card.dart';

class HomeAdminView extends StatelessWidget {
  final bool orderedByKasir;
  const HomeAdminView({super.key, this.orderedByKasir = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: primaryPadding,
        child: ValueListenableBuilder<int>(
            valueListenable: HomeAdminController.currentFilter,
            builder: (_, currentFilter, __) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.pin_drop_outlined,
                        color: secondaryColor,
                        size: 24.0,
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: Text(
                          "Jl. Lumbu Tengah IIIF No.28",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: semibold,
                            color: secondaryColor,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showConfirmation(
                            onPressed: () async {
                              await FirebaseAuthService.logout();
                            },
                          );
                        },
                        icon: Icon(
                          Icons.logout,
                          color: Colors.red[700],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: HomeAdminController.getOrders(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: secondaryColor,
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              "Terjadi Kesalahan",
                              style: TextStyle(color: secondaryColor),
                            ),
                          );
                        } else if (snapshot.hasData) {
                          final data = snapshot.data;
                          return Column(
                            children: data!.docs.map((e) {
                              Map<String, dynamic> item = e.data();
                              return NewOrderCard(item: item);
                            }).toList(),
                          );
                        }
                        return const SizedBox();
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 250.0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14.0,
                      vertical: 8.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: radiusPrimary,
                      color: cardColor,
                    ),
                    child: SfCartesianChart(
                      title: ChartTitle(
                        text: "Grafik Pembeli",
                        textStyle: TextStyle(
                          color: secondaryColor,
                          fontSize: 11.0,
                        ),
                      ),
                      primaryXAxis: CategoryAxis(),
                      tooltipBehavior: HomeAdminController.tooltipBehavior,
                      series: <ChartSeries>[
                        SplineSeries<ChartData, String>(
                          dataSource: HomeAdminController.chartData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          animationDuration: 400,
                          color: whiteColor,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MenuButton(
                        icon: Icons.edit_note,
                        label: "Menu",
                        onTap: () {
                          Get.to(
                            page: const MenuView(),
                          );
                        },
                      ),
                      MenuButton(
                        icon: Icons.shopping_bag,
                        label: "POS",
                        onTap: () async {
                          Get.to(
                            page: const CartView(isAdmin: true),
                          );
                          CartService.totalQuantity();
                          CartService.totalPayment();
                          await CartController.getPoint();
                          CartController.paymentMethod = "";
                        },
                      ),
                      MenuButton(
                        icon: Icons.monetization_on,
                        label: "Cashback",
                        onTap: () {
                          showMyQrCode("Klaim Point User");
                        },
                      ),
                      MenuButton(
                        icon: Icons.trending_up,
                        label: "Riwayat",
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MenuButton(
                        icon: Icons.point_of_sale,
                        label: "Top Up",
                        onTap: () {
                          Get.to(
                            page: const TopUpView(),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Text(
                    "Menu yang tersedia",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: bold,
                      color: whiteColor,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: PrimaryButton(
                          backgroundButton: currentFilter == 0
                              ? yellowColor
                              : backgroundColor.withOpacity(.2),
                          label: "Makanan",
                          onPressed: () {
                            HomeAdminController.handleFilter(0);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        flex: 1,
                        child: PrimaryButton(
                          backgroundButton: currentFilter == 1
                              ? yellowColor
                              : backgroundColor.withOpacity(.2),
                          label: "Minuman",
                          onPressed: () {
                            HomeAdminController.handleFilter(1);
                          },
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
                      } else if (s.hasData) {
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
