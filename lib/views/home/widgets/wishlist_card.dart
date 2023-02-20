import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ibu_usman/services/wishliat_service.dart';

import '../../../services/cart_service.dart';
import '../../../shared/utils/currency_format.dart';
import '../../../shared/utils/state_util.dart';
import '../../../shared/utils/style/border_radius.dart';
import '../../../shared/utils/style/color.dart';
import '../../../shared/utils/style/font_weight.dart';
import '../../../shared/utils/utility/show_succes.dart';

class WishlistCard extends StatelessWidget {
  const WishlistCard(
    this.product, {
    super.key,
  });
  final dynamic product;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List>(
        valueListenable: WishlistService.wishList,
        builder: (_, wishList, __) {
          return Container(
            width: Get.width,
            margin: const EdgeInsets.only(bottom: 15.0),
            decoration: BoxDecoration(
              borderRadius: radiusPrimary,
              color: cardColor,
            ),
            child: Slidable(
              endActionPane: ActionPane(
                extentRatio: 0.3,
                motion: const StretchMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      WishlistService.removeWishlist(product["id"]);
                      showSuccess();
                    },
                    backgroundColor: yellowColor,
                    foregroundColor: warningColor,
                    icon: Icons.favorite,
                  ),
                  SlidableAction(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(radiusPrimarySize),
                      bottomRight: Radius.circular(radiusPrimarySize),
                    ),
                    onPressed: (context) {
                      CartService.addCart(
                        id: product["id"],
                        name: product["name"],
                        price: product["price"].toString(),
                        type: product["type"],
                        photoUrl: product["photoUrl"],
                      );
                      showSuccess();
                    },
                    backgroundColor: warningColor,
                    foregroundColor: whiteColor,
                    icon: Icons.add_circle_outline,
                  ),
                ],
              ),
              child: Container(
                width: Get.width,
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 15.0),
                decoration: BoxDecoration(
                  borderRadius: radiusPrimary,
                  color: cardColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 100.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: whiteColor,
                                spreadRadius: 4.0,
                                blurRadius: 2.0,
                                blurStyle: BlurStyle.outer,
                              )
                            ],
                            borderRadius: BorderRadius.circular(50.0),
                            image: DecorationImage(
                              image: NetworkImage(
                                product["photoUrl"],
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 18.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product["name"],
                              style: TextStyle(
                                fontWeight: semibold,
                                color: whiteColor,
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              product["type"],
                              style: TextStyle(
                                fontWeight: semibold,
                                fontSize: 12.0,
                                color: const Color(0xffA5A5BA),
                              ),
                            ),
                            const SizedBox(
                              height: 24.0,
                            ),
                            Text(
                              CurrencyFormat.convertToIdr(product["price"], 2),
                              style: TextStyle(
                                fontWeight: semibold,
                                color: warningColor,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
