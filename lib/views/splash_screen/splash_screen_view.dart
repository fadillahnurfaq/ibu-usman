import 'package:flutter/material.dart';
import 'package:ibu_usman/controllers/splash_screen/splash_screen_controller.dart';
import 'package:ibu_usman/shared/utils/style/assets.dart';
import 'package:ibu_usman/shared/utils/style/color.dart';
import 'package:ibu_usman/shared/utils/style/font_weight.dart';

import '../../shared/utils/state_util.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    SplashScreenController.navigateTo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                Assets.backgroundSplashScreen(),
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ibu",
                style: TextStyle(
                  fontSize: 60.0,
                  fontWeight: medium,
                  color: secondaryColor,
                ),
              ),
              Text(
                "Usman",
                style: TextStyle(
                  fontSize: 60.0,
                  fontWeight: bold,
                  color: warningColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
