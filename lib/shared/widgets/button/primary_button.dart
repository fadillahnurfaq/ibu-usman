import 'package:flutter/material.dart';
import '../../utils/state_util.dart';
import '../../utils/style/border_radius.dart';
import '../../utils/style/color.dart';
import '../../utils/style/font_weight.dart';
import '../../utils/style/size.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.width,
    this.height,
    required this.label,
    this.icon,
    this.backgroundButton,
    required this.onPressed,
  });
  final double? width;
  final double? height;
  final String label;
  final IconData? icon;
  final Color? backgroundButton;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? Get.width,
      height: height ?? heightButton,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundButton ?? primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: radiusPrimary,
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            color: whiteColor,
            fontWeight: medium,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
