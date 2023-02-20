import 'package:flutter/material.dart';

import '../../utils/style/color.dart';

class PrimaryMenuButton extends StatelessWidget {
  const PrimaryMenuButton({
    super.key,
    this.icon,
    this.color,
    required this.label,
    required this.onTap,
  });
  final Widget? icon;
  final Color? color;
  final String label;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Row(
          children: [
            SizedBox(
              child: icon,
            ),
            if (icon != null)
              const SizedBox(
                width: 15.0,
              ),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12.0,
                  color: color ?? secondaryColor,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 24.0,
              color: color ?? secondaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
