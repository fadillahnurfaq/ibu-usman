import 'package:flutter/material.dart';
import 'package:ibu_usman/controllers/home/user/cart_controller.dart';
import 'package:ibu_usman/shared/utils/state_util.dart';

import '../shared/utils/session.dart';

class CartService extends ChangeNotifier {
  static ValueNotifier<int> quantity = ValueNotifier(0);
  static ValueNotifier<List> cart =
      ValueNotifier(mainStorage.get("cart") ?? []);
  static ValueNotifier<double> total = ValueNotifier(0.0);

  static Future<void> saveToLocalStorage() async {
    await mainStorage.put("cart", cart.value);
  }

  static isCart(String id) {
    if (cart.value.indexWhere((element) => element["id"] == id) == -1) {
      return false;
    } else {
      return true;
    }
  }

  static addCart({
    required String id,
    required String name,
    required String price,
    required String type,
    required String photoUrl,
  }) {
    if (!isCart(id)) {
      cart.value.add({
        "id": id,
        "name": name,
        "price": price,
        "type": type,
        "photoUrl": photoUrl,
        "quantity": 1,
      });
    } else {
      addQuantity(id);
    }

    saveToLocalStorage();
  }

  static removeCart(String id) {
    cart.value.removeWhere((element) => element["id"] == id);
    saveToLocalStorage();
    cart.notifyListeners();
    totalQuantity();
    totalPayment();
    CartController.getPoint();
    if (cart.value.isEmpty) {
      Get.back();
    }
  }

  static emptyCart() {
    mainStorage.put("cart", []);
    cart.value.clear();
    cart.notifyListeners();
  }

  static addQuantity(String id) async {
    var targetIndex = cart.value.indexWhere((waste) => waste["id"] == id);
    cart.value[targetIndex]["quantity"]++;
    cart.notifyListeners();
    await saveToLocalStorage();
    totalQuantity();
    totalPayment();

    await CartController.getPoint();
  }

  static reduceQuantity(String id) async {
    var targetIndex = cart.value.indexWhere((waste) => waste["id"] == id);
    if (cart.value[targetIndex]["quantity"] > 1) {
      cart.value[targetIndex]["quantity"]--;
      saveToLocalStorage();
      cart.notifyListeners();
      totalQuantity();
      totalPayment();
      await CartController.getPoint();
    }
  }

  static Future<void> totalQuantity() async {
    double totalQuantity = 0;

    for (var i = 0; i < cart.value.length; i++) {
      totalQuantity += cart.value[i]["quantity"];
    }
    quantity.value = totalQuantity.toInt();
    quantity.notifyListeners();
  }

  static void totalPayment() {
    double totalPayment = 0;

    for (var i = 0; i < cart.value.length; i++) {
      totalPayment +=
          (double.parse(cart.value[i]["price"]) * cart.value[i]["quantity"]);
    }

    total.value = totalPayment;
    total.notifyListeners();
  }
}
