import 'package:cloud_firestore/cloud_firestore.dart';

class HistorPointyController {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Stream<QuerySnapshot<Map<String, dynamic>>> getOrders() async* {
    yield* firestore
        .collection("points")
        .orderBy("created_at", descending: true)
        .snapshots();
  }
}
