import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ibu_usman/services/chart_service.dart';
import 'package:ibu_usman/services/firebase_auth_service.dart';
import 'package:path_provider/path_provider.dart';

import 'firebase_options.dart';
import 'shared/utils/session.dart';

Future initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb && !Platform.isWindows) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  var path = await getTemporaryDirectory();
  Hive.init(path.path);
  mainStorage = await Hive.openBox("mainStorage");
  if (FirebaseAuthService.user != null) {
    ChartService.getHistories().listen(
      (event) => ChartService.chart = event,
    );
  }
}
