import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth auth;

  AuthService({required this.auth});

  Future<void> signUp({required String email,required String password}) async {
    await auth.createUserWithEmailAndPassword(
      email: email.trim(), 
      password: password.trim()
    );
  }

  Future<void> signIn({required String email,required String password}) async {
    await auth.signInWithEmailAndPassword(
      email: email.trim(), 
      password: password.trim()
    );
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}