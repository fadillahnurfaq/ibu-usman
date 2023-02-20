import 'package:flutter/material.dart';
import 'package:ibu_usman/models/user_model.dart';
import 'package:ibu_usman/services/user_services.dart';
import 'package:ibu_usman/shared/utils/state_util.dart';
import 'package:ibu_usman/shared/utils/utility/show_alert.dart';
import 'package:ibu_usman/shared/utils/utility/show_loading.dart';
import 'package:ibu_usman/shared/utils/utility/show_succes.dart';
import 'package:ibu_usman/views/profile/profile_view.dart';

class EditProfileController {
  static TextEditingController name = TextEditingController();
  static TextEditingController phoneNumber = TextEditingController();
  static String photo = "";

  static Future<void> updateProfile() async {
    try {
      showLoading();
      await UserService.updateUser(
          name: name.text, phoneNumber: phoneNumber.text, photoUrl: photo);
      Get.back();
      Get.back();
      showSuccess();
    } catch (e) {
      Get.put(page: const ProfileView());
      showAlert("Error", e.toString());
    }
  }

  static Future<void> disposes() async {
    name.dispose();
    phoneNumber.dispose();
    photo = "";
  }

  static void init(UserModel data) {
    name = TextEditingController();
    phoneNumber = TextEditingController();
    name.text = data.name ?? "";
    phoneNumber.text = data.phoneNumber ?? "";
    photo = data.photo ?? "";
  }
}
