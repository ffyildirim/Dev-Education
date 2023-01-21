import 'package:dev_edu/repository/auth_repository.dart';
import 'package:dev_edu/service/auth_base.dart';
import 'package:dev_edu/service/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {

  AuthRepository authRepository = AuthRepository();

  Future<UserModel?> currentUser() async {
    return authRepository.currentUser();
  }

  Future<UserModel?> signInWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        if (googleAuth.accessToken != null && googleAuth.idToken != null) {
          UserModel? user = await authRepository.signInWithGoogle(googleAuth: googleAuth);
          return user;
        }
      }
      return null;
    } catch(e) {
      return null;
    }
  }

  Future<bool> signOut() async {
    final bool status = await authRepository.signOut();
    return status;
  }

  Future<UserModel?> signUpWithEmailAndPassword({required String email, required String password}) async {
    UserModel? userModel = await authRepository.signUpWithEmailAndPassword(email: email, password: password);
    return userModel;
  }

  Future<UserModel?> signInWithEmailAndPassword({required String email, required String password}) async {
    UserModel? userModel = await authRepository.signInWithEmailAndPassword(email: email, password: password);
    return userModel;
  }

}