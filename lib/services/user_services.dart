import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_auth_service.dart';

DocumentReference get userCollection {
  return FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuthService.user?.uid);
}

class UserService {
  static createUserIfNotExists() async {
    var snapshot = await userCollection.get();
    if (!snapshot.exists) {
      await userCollection.set({
        "id": FirebaseAuthService.user?.uid,
        "name": FirebaseAuthService.user?.displayName,
        "email": FirebaseAuthService.user?.email,
        "phone_number": FirebaseAuthService.user?.phoneNumber,
        "photo": FirebaseAuthService.user?.photoURL,
        "point": 0.0,
        "is_admin": false,
      });
    }
  }

  static updateUser({
    required String name,
    required String phoneNumber,
    required String photoUrl,
  }) async {
    await userCollection.set(
      {
        "name": name,
        "phone_number": phoneNumber,
        "photo": photoUrl,
      },
      SetOptions(merge: true),
    );
  }

  static updatePoint({
    required double point,
  }) async {
    await userCollection.update({
      "point": FieldValue.increment(point),
    });
  }

  static Future<Map<String, dynamic>> getUserData() async {
    late Map<String, dynamic> data;
    var hasilFromCollection = await userCollection.get();

    if (hasilFromCollection.data() != null) {
      data = hasilFromCollection.data() as Map<String, dynamic>;
    } else {
      data = {
        "id": FirebaseAuthService.user?.uid,
        "name": FirebaseAuthService.user?.displayName,
        "email": FirebaseAuthService.user?.email,
        "phone_number": FirebaseAuthService.user?.phoneNumber,
        "photo": FirebaseAuthService.user?.photoURL,
      };
    }

    return data;
  }
}
