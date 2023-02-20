import 'package:flutter/material.dart';
import 'package:ibu_usman/controllers/auth/auth_controller.dart';
import 'package:ibu_usman/shared/utils/state_util.dart';
import 'package:ibu_usman/shared/utils/style/assets.dart';
import 'package:ibu_usman/shared/utils/style/size.dart';
import 'package:ibu_usman/shared/widgets/button/outline_secondary_button.dart';
import '../../shared/utils/style/color.dart';
import '../../shared/utils/style/font_weight.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: horizontalSize),
        child: Container(
          height: Get.height,
          width: Get.width,
          padding: primaryVerticalSize,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Mari Kita Mulai 😁",
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: medium,
                  color: whiteColor,
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                "Skuyy login untuk menikmati menu-menu\nyang ada di restoran kami",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: medium,
                  color: secondaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 40.0,
              ),
              OutlineSecondaryButton(
                icon: Image.asset(
                  Assets.google(),
                  width: 24,
                  height: 24,
                  fit: BoxFit.cover,
                ),
                label: "Lanjutkan Dengan Google",
                onPressed: () {
                  AuthController.loginWithGoogle();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
