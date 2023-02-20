import 'package:flutter/foundation.dart';
import 'package:ibu_usman/models/products_model.dart';
import 'package:ibu_usman/shared/utils/print_debug.dart';

import '../shared/utils/session.dart';

class WishlistService extends ChangeNotifier {
  // List wishlist = mainStorage.get("wishlist") ?? [];
  static ValueNotifier<List> wishList =
      ValueNotifier(mainStorage.get("wishlist") ?? []);

  static saveToLocalStorage() async {
    await mainStorage.put("wishlist", wishList.value);
  }

  static addProduct(ProductsModel product) {
    if (!isWishlist(product)) {
      wishList.value.add({
        "id": product.id,
        "name": product.name,
        "price": product.price,
        "type": product.type,
        "photoUrl": product.photoUrl,
      });
    } else {
      wishList.value.removeWhere((element) => element["id"] == product.id);
    }

    saveToLocalStorage();
    wishList.notifyListeners();
    PrintDebug.printDebug('Successfully: ${wishList.value}');
  }

  static isWishlist(ProductsModel product) {
    if (wishList.value.indexWhere((element) => element["id"] == product.id) ==
        -1) {
      return false;
    } else {
      return true;
    }
  }

  static removeWishlist(String id) {
    wishList.value.removeWhere((element) => element["id"] == id);
    saveToLocalStorage();
    wishList.notifyListeners();
    PrintDebug.printDebug('Successfully: ${wishList.value}');
  }
}
