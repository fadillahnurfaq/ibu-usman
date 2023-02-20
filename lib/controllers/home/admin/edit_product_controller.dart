import 'package:flutter/material.dart';
import 'package:ibu_usman/services/product_service.dart';
import 'package:ibu_usman/shared/utils/state_util.dart';
import 'package:ibu_usman/shared/utils/utility/show_alert.dart';
import 'package:ibu_usman/shared/utils/utility/show_loading.dart';
import 'package:ibu_usman/shared/utils/utility/show_succes.dart';
import 'package:ibu_usman/views/home/admin/home_admin_view.dart';

class EditProductController {
  static TextEditingController name = TextEditingController();
  static TextEditingController price = TextEditingController();
  static String photoUrl = "";
  static String type = "";

  static Future<void> editProduct({required String id}) async {
    showLoading();
    try {
      await ProductService.editProduct(
        id: id,
        name: name.text,
        price: int.tryParse(price.text) ?? 0,
        type: type,
        photoUrl: photoUrl,
      );
      clear();
      Get.offAll(page: const HomeAdminView());
      showSuccess();
    } catch (e) {
      Get.back();
      showAlert("Error", e.toString());
    }
  }

  static void clear() {
    photoUrl = "";
    type = "";
    name.clear();
    price.clear();
  }
}
