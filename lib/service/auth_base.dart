import 'package:google_sign_in/google_sign_in.dart';

import 'models/user_model.dart';

abstract class AuthBase {
  Future<UserModel?> currentUser();
  Future<UserModel?> signInWithGoogle({ required GoogleSignInAuthentication googleAuth });
  Future<UserModel?> signUpWithEmailAndPassword({ required String email, required String password });
  Future<UserModel?> signInWithEmailAndPassword({ required String email, required String password });
  Future<bool> signOut();
}