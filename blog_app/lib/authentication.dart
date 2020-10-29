import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthOperation {
  Future<String> signIn(String email, String password);
  Future<String> signUp(String email, String password);
  Future<void> signOut();
  Future<String> getCurrentUser();
}

class AuthService implements AuthOperation {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
    AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<String> signUp(String email, String password) async {
    AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<String> getCurrentUser() async {
    FirebaseUser user = await _auth.currentUser();
    if (user == null) {
      return null;
    }
    return user.uid;
  }
}
