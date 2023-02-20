import 'package:flutter/material.dart';
import 'package:ibu_usman/shared/utils/currency_format.dart';
import 'package:ibu_usman/views/home/user/order_detail_view.dart';

import '../../../shared/utils/state_util.dart';
import '../../../shared/utils/style/border_radius.dart';
import '../../../shared/utils/style/color.dart';
import '../../../shared/utils/style/font_weight.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard(
    this.history, {
    super.key,
  });
  final Map<String, dynamic> history;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
      child: Material(
        color: cardColor,
        borderRadius: radiusPrimary,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Get.to(
                page: OrderDetailView(
              history: history,
              isPosAdmin: false,
            ));
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 7.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: radiusPrimary,
                        color: history["status"] == "Selesai"
                            ? primaryColor
                            : history["status"] == "Ditolak"
                                ? Colors.red
                                : warningColor,
                      ),
                      child: Text(
                        "${history["status"]}",
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: medium,
                          color: whiteColor,
                        ),
                      ),
                    ),
                    Text(
                      "${history["quantity"]} item",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: secondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: lightColor, thickness: 1.0),
              const SizedBox(
                height: 4.0,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 50.0,
                          width: 50.0,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: whiteColor,
                                spreadRadius: 4.0,
                                blurRadius: 2.0,
                                blurStyle: BlurStyle.outer,
                              )
                            ],
                            borderRadius: radiusPrimary,
                            image: DecorationImage(
                              image: NetworkImage(
                                "${history["products"][0]["photoUrl"]}",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: Get.width - 280.0,
                              child: Text(
                                history["quantity"] > 1
                                    ? '${history["products"][0]["name"]}'
                                    : '${history["products"][0]["name"]}',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: medium,
                                  color: whiteColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              "${CurrencyFormat.convertToIdr(history["total_payment"], 2)} Total Harga",
                              style: TextStyle(
                                fontSize: 12.0,
                                color: secondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: secondaryColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
