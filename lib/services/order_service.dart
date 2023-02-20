import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ibu_usman/shared/utils/print_debug.dart';
import 'package:ibu_usman/shared/utils/utility/show_alert.dart';

class OrderService {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<void> addOrder({
    required String id,
    required int quantity,
    required String paymentMethod,
    required double totalPrice,
    required double pointUsed,
    required double totalPayment,
    required String status,
    required List products,
    required Map user,
  }) async {
    try {
      firestore.collection('orders').doc(id).set({
        'id': id,
        'quantity': quantity,
        'payment_method': paymentMethod,
        'total_price': totalPrice,
        'point_used': pointUsed,
        'total_payment': totalPayment,
        'status': status,
        'products': products,
        'user': user,
        'created_at': DateTime.now().toString(),
        'updated_at': DateTime.now().toString(),
      });
    } catch (e) {
      // throw Exception('Data gagal disimpan, silahkan dicoba lagi');
      showAlert("Error", e.toString());
    }
  }

  static Future<void> markAsDone(String id) async {
    try {
      firestore.collection('orders').doc(id).set({
        'status': "Selesai",
        'updated_at': DateTime.now().toString(),
      }, SetOptions(merge: true));
    } catch (e) {
      PrintDebug.printDebug(e.toString());
    }
  }

  static Future<void> markAsReject(String id) async {
    try {
      firestore.collection('orders').doc(id).set({
        'status': "Ditolak",
        'updated_at': DateTime.now().toString(),
      }, SetOptions(merge: true));
    } catch (e) {
      PrintDebug.printDebug(e.toString());
    }
  }

  static Future<void> deleteOrder(String id) async {
    try {
      firestore.collection('orders').doc(id).delete();
    } catch (e) {
      PrintDebug.printDebug(e.toString());
    }
  }

  static Future<void> getOrderFromAdmin(
      {required String id, required Map<String, dynamic> userData}) async {
    try {
      firestore.collection('orders').doc(id).set({
        'status': "Selesai",
        'user': userData,
        'updated_at': DateTime.now().toString(),
      }, SetOptions(merge: true));
    } catch (e) {
      PrintDebug.printDebug(e.toString());
    }
  }
}
