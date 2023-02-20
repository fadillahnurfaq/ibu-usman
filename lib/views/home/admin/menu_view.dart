import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ibu_usman/controllers/home/admin/menu_controller.dart';
import 'package:ibu_usman/shared/utils/state_util.dart';
import 'package:ibu_usman/shared/utils/style/size.dart';
import 'package:ibu_usman/views/home/admin/add_product_view.dart';

import '../../../models/products_model.dart';
import '../../../services/product_service.dart';
import '../../../shared/utils/style/color.dart';
import '../../../shared/widgets/button/primary_button.dart';
import '../widgets/product_card.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: primaryPadding,
        child: ValueListenableBuilder<int>(
            valueListenable: MenuViewController.currentFilter,
            builder: (_, currentFilter, __) {
              return Column(
                children: [
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
                            MenuViewController.handleFilter(0);
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
                            MenuViewController.handleFilter(1);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Material(
                          borderRadius: BorderRadius.circular(50),
                          color: cardColor,
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            onTap: () {
                              Get.to(page: const AddProductView());
                            },
                            child: SizedBox(
                              height: 50,
                              width: 50,
                              // margin: const EdgeInsets.only(left: 10),
                              child: Icon(
                                Icons.post_add,
                                color: secondaryColor,
                              ),
                            ),
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
                      } else if (s.data!.docs.isNotEmpty) {
                        List<ProductsModel> product = [];
                        for (var e in s.data!.docs) {
                          product.add(ProductsModel.fromJson(e.data()));
                        }
                        return Column(
                          children: product
                              .map((e) => ProductCard(
                                    e,
                                    isAdmin: true,
                                  ))
                              .toList(),
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
