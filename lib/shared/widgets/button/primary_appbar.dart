import 'package:flutter/material.dart';
import '../../utils/style/border_radius.dart';
import '../../utils/style/color.dart';
import '../../utils/style/font_weight.dart';

class PrimaryAppBar extends StatelessWidget {
  final void Function() onPressed;
  const PrimaryAppBar({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Material(
          borderRadius: radiusPrimary,
          color: cardColor,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onPressed,
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
        )
      ],
    );
  }
}
