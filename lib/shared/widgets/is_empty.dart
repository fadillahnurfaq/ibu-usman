import 'package:flutter/material.dart';

import '../utils/style/color.dart';
import '../utils/style/font_weight.dart';

class IsEmpty extends StatelessWidget {
  const IsEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Data tidak tersedia",
        style: TextStyle(
          fontWeight: medium,
          color: secondaryColor,
        ),
      ),
    );
  }
}
