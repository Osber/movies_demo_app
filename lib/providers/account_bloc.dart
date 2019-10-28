import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class AccountBloc extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthStatus _status = AuthStatus.NOT_LOGGED_IN;
  AuthStatus get status => _status;

  Future<String> signIn(String email, String password) async {
    AuthResult result;
    try {
      result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      _status = AuthStatus.LOGGED_IN;
    } catch (e) {
      _status = AuthStatus.NOT_LOGGED_IN;
    }

    FirebaseUser user = result.user;
    if (user != null) notifyListeners();
    return user.uid;
  }

  Future<String> signUp(String email, String password) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> signOut() async {
    _status = AuthStatus.NOT_LOGGED_IN;
    notifyListeners();
    return _firebaseAuth.signOut();
  }

/*   Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  } */
}
