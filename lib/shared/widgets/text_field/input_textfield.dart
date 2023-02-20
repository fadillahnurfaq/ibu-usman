import 'package:flutter/material.dart';

import '../../utils/state_util.dart';
import '../../utils/style/border_radius.dart';
import '../../utils/style/color.dart';
import 'input_textfield_controller.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    super.key,
    this.hintText,
    this.prefixIcon,
    this.keyboardType,
    this.strokeColorInput,
    this.backgroundInput,
    required this.massageValidator,
    // required this.value,
    required this.controller,
    // required this.onChanged,
    required this.hide,
  });

  final String? hintText;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final Color? strokeColorInput;
  final Color? backgroundInput;
  // final String value;
  final bool hide;
  // final void Function(String) onChanged;
  final String massageValidator;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: SizedBox(
        width: Get.width,
        child: ValueListenableBuilder<bool>(
          valueListenable: InputTextfieldController.showPassword,
          builder: (_, showPassword, __) {
            return TextFormField(
              style: TextStyle(color: secondaryColor),
              // initialValue: value,
              keyboardType: keyboardType,
              obscureText: showPassword,
              decoration: InputDecoration(
                contentPadding: prefixIcon != null
                    ? const EdgeInsets.only(top: 14.0)
                    : const EdgeInsets.all(18.0),
                filled: true,
                hintText: hintText,
                prefixIcon: prefixIcon != null
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: prefixIcon,
                      )
                    : null,
                suffixIcon: hide == false
                    ? IconButton(
                        onPressed: () {
                          InputTextfieldController.changeShowPassword();
                        },
                        icon: Icon(
                          showPassword
                              ? Icons.visibility_off_outlined
                              : Icons.remove_red_eye_outlined,
                          color: strokeColor,
                          size: 22,
                        ),
                      )
                    : null,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radiusPrimarySize),
                  borderSide: BorderSide(color: lightColor, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radiusPrimarySize),
                  borderSide: BorderSide(color: strokeColor, width: 1.0),
                ),
                hoverColor: secondaryColor,
                hintStyle: TextStyle(color: strokeColor),
              ),
              controller: controller,
              // onChanged: onChanged,
              validator: (value) {
                if (value!.isEmpty) {
                  return massageValidator;
                } else {
                  return null;
                }
              },
            );
          },
        ),
      ),
    );
  }
}
