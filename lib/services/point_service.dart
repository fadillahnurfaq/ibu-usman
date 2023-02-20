import 'package:cloud_firestore/cloud_firestore.dart';

class PointService {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<bool> addPoint({
    required double point,
    required Map userData,
  }) async {
    await firestore.collection("points").add({
      "point": point,
      "user": userData,
      'created_at': DateTime.now().toString(),
    });

    return true;
  }
}
