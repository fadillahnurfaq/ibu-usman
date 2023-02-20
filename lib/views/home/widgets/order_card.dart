import "package:flutter/material.dart";

import "../../../shared/utils/currency_format.dart";
import "../../../shared/utils/style/color.dart";
import "../../../shared/utils/style/font_weight.dart";

class OrderCard extends StatelessWidget {
  final Map<dynamic, dynamic> product;
  const OrderCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Text(
            "${product["quantity"]}x",
            style: TextStyle(
              fontWeight: semibold,
              color: lightColor,
            ),
          ),
          const SizedBox(
            width: 12.0,
          ),
          CircleAvatar(
            backgroundImage: NetworkImage("${product["photoUrl"]}"),
          ),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Text(
              "${product["name"]}",
              style: TextStyle(
                fontWeight: semibold,
                color: lightColor,
              ),
            ),
          ),
          Text(
            CurrencyFormat.convertToIdr(double.parse("${product["price"]}"), 2),
            style: TextStyle(
              fontWeight: semibold,
              color: whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
