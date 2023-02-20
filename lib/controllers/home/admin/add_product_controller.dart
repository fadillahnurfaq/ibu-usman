import 'package:flutter/material.dart';
import 'package:ibu_usman/services/product_service.dart';
import 'package:ibu_usman/shared/utils/state_util.dart';
import 'package:ibu_usman/shared/utils/utility/show_alert.dart';
import 'package:ibu_usman/shared/utils/utility/show_loading.dart';
import 'package:ibu_usman/shared/utils/utility/show_succes.dart';
import 'package:ibu_usman/views/home/admin/home_admin_view.dart';

class AddProductController {
  static TextEditingController name = TextEditingController();
  static TextEditingController price = TextEditingController();
  static String photoUrl = "";
  static String type = "";

  static Future<void> addProduct() async {
    showLoading();
    try {
      await ProductService.addProduct(
        name: name.text,
        price: int.tryParse(price.text) ?? 0,
        type: type,
        photoUrl: photoUrl,
      );
      Get.offAll(page: const HomeAdminView());
      showSuccess();
    } catch (e) {
      Get.back();
      showAlert("Error", e.toString());
    }
  }

  static Future<void> dispose() async {
    name.dispose();
    price.dispose();
    photoUrl = "";
    type = "";
  }

  static Future<void> init() async {
    name = TextEditingController();
    price = TextEditingController();
  }
}
