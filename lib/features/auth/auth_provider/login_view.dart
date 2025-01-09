import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final authServiceProvider = Provider(
  (ref) => AuthService(
    auth: FirebaseAuth.instance,
    googleSignIn: GoogleSignIn(),
  ),
);

class AuthService {
  FirebaseAuth auth;
  GoogleSignIn googleSignIn;
  AuthService({
    required this.auth,
    required this.googleSignIn,
  });

  //function that gives the current userName of the user if present else null
  Future<String?> getUserName() async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        return user.displayName;
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  //function to sign out
  Future<void> signOut() async {
    try {
      await googleSignIn.signOut();
      await auth.signOut();
    } catch (e) {
      print('Error: $e');
    }
  }

  // Sign in with Google
  Future<bool> signInWithGoogle() async {
    try {
      final user = await googleSignIn.signIn();
      final googleAuth = await user!.authentication;
      final credencial = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await auth.signInWithCredential(credencial);
      return true;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
