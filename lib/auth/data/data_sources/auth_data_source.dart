import 'package:firebase_auth/firebase_auth.dart';

import '../../../utilities/errors/exceptions.dart';

abstract class AuthDataSource {
  User? get currentUser;

  Stream<User?> authStateChange();

  Future<User?> loginWithEmailAndPassword(String email, String password);

  Future<User?> signUpWithEmailAndPassword(String email, String password);
}

class AuthDataSourceImpl extends AuthDataSource {
  final FirebaseAuth? auth;

  AuthDataSourceImpl(this.auth);
  //AuthDataSourceImpl({required this.auth}); todo

  @override
  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    try {
      await auth!
          .signInWithEmailAndPassword(email: email, password: password)
          .then((UserCredential user) {
        return user.user;
      });
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: getMessageFromErrorCode(e.code));
    }
  }

  @override
  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      await auth!
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((UserCredential user) {
        return user.user;
      });
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: getMessageFromErrorCode(e.code));
    }
  }

  @override
  Stream<User?> authStateChange() => auth!.authStateChanges();

  @override
  User? get currentUser => auth!.currentUser;

  String getMessageFromErrorCode(String code) {
    switch (code) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "Email already used. Go to login page.";

      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return "Wrong email/password combination.";

      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return "No user found with this email.";

      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return "User disabled.";

      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        return "Too many requests to log into this account.";


      case "operation-not-allowed":
      case "ERROR_OPERATION_NOT_ALLOWED":
        return "Server error, please try again later.";

      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return "Email address is invalid.";

      default:
        return "Login failed. Please try again.";
    }
  }


}
