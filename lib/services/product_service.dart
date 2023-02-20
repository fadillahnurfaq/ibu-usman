import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ibu_usman/shared/utils/utility/show_alert.dart';
import 'package:uuid/uuid.dart';

class ProductService {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Stream<QuerySnapshot<Map<String, dynamic>>> getProduct(
      {required String type}) async* {
    yield* firestore
        .collection("products")
        .where("type", isEqualTo: type)
        .snapshots();
  }

  static Future<void> addProduct({
    required String name,
    required int price,
    required String type,
    required String photoUrl,
  }) async {
    String id = const Uuid().v4();
    try {
      firestore.collection("products").doc(id).set({
        "id": id,
        'name': name,
        'price': price,
        'type': type,
        'photoUrl': photoUrl,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      showAlert("Opps", e.toString());
    }
  }

  static Future<void> editProduct({
    required String id,
    required String name,
    required int price,
    required String type,
    required String photoUrl,
  }) async {
    try {
      firestore.collection('products').doc(id).set({
        'name': name,
        'price': price,
        'type': type,
        'photoUrl': photoUrl,
        'updated_at': DateTime.now().toString(),
      });
    } catch (e) {
      throw Exception('Data gagal disimpan, silahkan dicoba lagi');
    }
  }

  static Future<void> deleteProduct({
    required String id,
  }) async {
    try {
      firestore.collection('products').doc(id).delete();
    } catch (e) {
      throw Exception('Data gagal disimpan, silahkan dicoba lagi');
    }
  }
}
