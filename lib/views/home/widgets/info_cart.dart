import 'package:flutter/material.dart';

import '../../../shared/utils/style/color.dart';
import '../../../shared/utils/style/font_weight.dart';

class InfoCart extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;
  const InfoCart(
      {super.key,
      required this.label,
      required this.value,
      this.isTotal = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: medium,
              color: secondaryColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: isTotal ? extrabold : medium,
              color: isTotal ? warningColor : secondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
