import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../shared/utils/currency_format.dart';
import '../../../shared/utils/style/color.dart';
import '../../../shared/utils/style/font_weight.dart';

class HistoryPointCard extends StatelessWidget {
  const HistoryPointCard(
      {super.key, required this.item, required this.plusOrNegative});
  final String plusOrNegative;
  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            DateFormat("H:m - dd MMM y")
                .format(DateTime.parse(item["created_at"])),
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: medium,
              color: secondaryColor,
            ),
          ),
          Text(
            "$plusOrNegative${CurrencyFormat.convertToIdr(item["point"], 2)}",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: medium,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
