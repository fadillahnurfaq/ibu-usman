import 'package:ibu_usman/services/firebase_auth_service.dart';
import 'package:ibu_usman/shared/utils/state_util.dart';
import 'package:ibu_usman/shared/utils/utility/show_alert.dart';
import 'package:ibu_usman/views/home/admin/home_admin_view.dart';

import '../../services/user_services.dart';
import '../../shared/utils/utility/show_loading.dart';
import '../../views/main_navigation/main_navigation_view.dart';

class AuthController {
  static String email = "ibu_usman@gmail.com";
  static String password = "";

  static loginWithGoogle() async {
    showLoading();

    if (await FirebaseAuthService.signInWithGoogle()) {
      await UserService.createUserIfNotExists();
      if (FirebaseAuthService.user?.email == "fadillahnurfaq3@gmail.com") {
        Get.put(page: const HomeAdminView());
      } else {
        Get.offAll(page: const MainNavigationView());
      }
    } else {
      Get.back();
      showAlert("Oppsss", "Login gagal");
    }
  }
}
