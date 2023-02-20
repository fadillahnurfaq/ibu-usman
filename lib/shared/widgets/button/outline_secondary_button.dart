import 'package:flutter/material.dart';

import '../../utils/state_util.dart';
import '../../utils/style/border_radius.dart';
import '../../utils/style/color.dart';
import '../../utils/style/font_weight.dart';
import '../../utils/style/size.dart';

class OutlineSecondaryButton extends StatelessWidget {
  const OutlineSecondaryButton({
    super.key,
    required this.label,
    this.icon,
    required this.onPressed,
  });
  final String label;
  final Widget? icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: heightButton,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: radiusPrimary,
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) SizedBox(child: icon),
            if (icon != null)
              const SizedBox(
                width: 8.0,
              ),
            Text(
              label,
              style: TextStyle(
                color: secondaryColor,
                fontWeight: medium,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
