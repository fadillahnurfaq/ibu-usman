import 'package:ibu_usman/shared/utils/session.dart';
import 'package:ibu_usman/shared/utils/state_util.dart';
import 'package:ibu_usman/views/auth/login_view.dart';
import 'package:ibu_usman/views/home/admin/home_admin_view.dart';
import 'package:ibu_usman/views/main_navigation/main_navigation_view.dart';

import '../../services/firebase_auth_service.dart';

class SplashScreenController {
  static navigateTo() {
    Future.delayed(
      const Duration(milliseconds: 1500),
      () async {
        if (SessionManager.isLogin) {
          Get.put(
            page: const HomeAdminView(),
          );
        } else {
          await FirebaseAuthService.autoLogin().then(
            (value) {
              if (value == true) {
                if (FirebaseAuthService.user?.email ==
                    "fadillahnurfaq3@gmail.com") {
                  Get.put(page: const HomeAdminView());
                } else {
                  Get.put(page: const MainNavigationView());
                }
              } else {
                Get.put(
                  page: const LoginView(),
                );
              }
            },
          );
        }
      },
    );
  }
}
