import 'package:flutter/material.dart';

import '../../../shared/utils/style/border_radius.dart';
import '../../../shared/utils/style/color.dart';

class MenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function()? onTap;
  const MenuButton(
      {super.key,
      required this.icon,
      required this.label,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: cardColor,
      borderRadius: radiusPrimary,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          onTap!();
        },
        child: Container(
          height: 80,
          width: 80,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: 40,
                margin: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  color: whiteColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 30,
                  color: cardColor,
                ),
              ),
              Text(
                label,
                style: TextStyle(fontSize: 12.0, color: secondaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
