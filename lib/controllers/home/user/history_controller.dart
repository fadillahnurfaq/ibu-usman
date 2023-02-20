import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryController {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Stream<QuerySnapshot<Map<String, dynamic>>> getOrders() async* {
    yield* firestore
        .collection("orders")
        .orderBy("created_at", descending: true)
        .snapshots();
  }
}
