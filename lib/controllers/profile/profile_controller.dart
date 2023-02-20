import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ibu_usman/services/user_services.dart';

class ProfileController {
  static Stream<DocumentSnapshot<Object?>> getUserData() async* {
    yield* userCollection.snapshots();
  }
}
