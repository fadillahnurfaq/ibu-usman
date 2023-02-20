import 'package:flutter/material.dart';

import 'package:ibu_usman/initialize.dart';
import 'package:ibu_usman/shared/utils/state_util.dart';
import 'package:ibu_usman/shared/utils/style/color.dart';
import 'package:ibu_usman/views/splash_screen/splash_screen_view.dart';

void main() async {
  await initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: Get.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: AppBarTheme(backgroundColor: backgroundColor),
      ),
      home: const SplashScreenView(),
    );
  }
}
