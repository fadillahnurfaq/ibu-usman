import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ibu_usman/models/user_model.dart';
import 'package:ibu_usman/services/cart_service.dart';
import 'package:ibu_usman/services/order_service.dart';
import 'package:ibu_usman/services/point_service.dart';
import 'package:ibu_usman/services/user_services.dart';
import 'package:ibu_usman/shared/utils/state_util.dart';
import 'package:ibu_usman/shared/utils/utility/show_alert.dart';
import 'package:ibu_usman/shared/utils/utility/show_confirmation.dart';
import 'package:ibu_usman/shared/utils/utility/show_loading.dart';
import 'package:ibu_usman/shared/utils/utility/show_succes.dart';
import 'package:ibu_usman/views/home/user/order_detail_view.dart';
import 'package:uuid/uuid.dart';

import '../../../services/firebase_auth_service.dart';

class CartController extends ChangeNotifier {
  static String paymentMethod = "";
  static bool isAdmin = false;
  static ValueNotifier<double> yourPoint = ValueNotifier(0.0);
  static ValueNotifier<double> totalPayment = ValueNotifier(0.0);
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<void> getPoint() async {
    if (isAdmin == false) {
      var hasil = await firestore
          .collection("users")
          .where("email", isEqualTo: FirebaseAuthService.user?.email)
          .get();

      UserModel data = UserModel.fromJson(hasil.docs.first.data());

      yourPoint.value = data.point?.toDouble() ?? 0.0;
    }
    double getPoint = CartService.total.value;
    if (yourPoint.value > getPoint) {
      yourPoint.value = getPoint;
    }
    totalPayment.value = CartService.total.value - yourPoint.value;
  }

  static Future<void> orderNow() async {
    if (CartService.quantity.value == 0) {
      Get.back();
      showAlert("Opps", "Tidak ada menu yang dipesan");
    } else {
      showConfirmation(
        onPressed: () async {
          if (paymentMethod == "") {
            showAlert("Oppss", "Check Kembali Inputan Anda");
          } else {
            showLoading();
            String id = const Uuid().v4();
            try {
              await OrderService.addOrder(
                id: id,
                quantity: CartService.quantity.value,
                paymentMethod: paymentMethod,
                totalPrice: CartService.total.value,
                pointUsed: yourPoint.value,
                totalPayment: totalPayment.value,
                status: "Dalam Proses",
                products: CartService.cart.value,
                user: isAdmin
                    ? {
                        "name": "Kasir",
                        "photo":
                            "https://user-images.githubusercontent.com/74108522/211291287-dcab15fe-6f08-41fc-b62b-0eb585c19008.png"
                      }
                    : await UserService.getUserData(),
              );
              if (!isAdmin) {
                await PointService.addPoint(
                  point: yourPoint.value,
                  userData: await UserService.getUserData(),
                );
              }
              CartService.emptyCart();
              CartService.totalQuantity();
              Get.back();
              var hasil = await firestore
                  .collection("orders")
                  .where("id", isEqualTo: id)
                  .get();

              Map<String, dynamic> history = hasil.docs.first.data();
              if (!isAdmin) {
                await showSuccess();
                await Get.put(page: OrderDetailView(history: history));
              } else {
                await showSuccess();
                await Get.put(
                    page: OrderDetailView(
                  history: history,
                  isPosAdmin: true,
                ));
              }
            } catch (e) {
              showAlert("Error", e.toString());
            }
          }
        },
      );
    }
  }
}
