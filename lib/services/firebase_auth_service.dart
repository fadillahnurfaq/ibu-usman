import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ibu_usman/controllers/home/user/main_navigation_controller.dart';
import 'package:ibu_usman/views/splash_screen/splash_screen_view.dart';

import '../shared/utils/session.dart';
import '../shared/utils/state_util.dart';

class FirebaseAuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static User? get user => _auth.currentUser;
  static GoogleSignInAccount? _currentUser;
  static GoogleSignIn _googleSignIn = GoogleSignIn();
  static UserCredential? userCredential;

  static Future<bool> signInWithGoogle() async {
    _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );

    try {
      await _googleSignIn.disconnect();
      await _googleSignIn.signOut();
    } catch (_) {}

    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);

      return Future.value(true);
    } catch (_) {
      return Future.value(false);
    }
  }

  static Future<bool> autoLogin() async {
    try {
      final isSignIn = await _googleSignIn.isSignedIn();
      if (isSignIn) {
        await _googleSignIn
            .signInSilently()
            .then((value) => _currentUser = value);
      }
      final googleAuth = await _currentUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) => userCredential = value);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<void> logout() async {
    mainStorage.clear();
    await _auth.signOut();
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    MainNavigationController.currentIndex.value = 0;
    Get.offAll(page: const SplashScreenView());
  }
}
