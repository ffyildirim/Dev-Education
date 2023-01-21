import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_edu/service/auth_base.dart';
import 'package:dev_edu/service/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'db_repository.dart';

class AuthRepository implements AuthBase {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  DBRepository dbRepository = DBRepository();

  @override
  Future<UserModel?> currentUser() async {
    User? user = firebaseAuth.currentUser;
    return _convert2UserModel(user);
  }
  @override
  Future<bool> signOut() async {
    try {
      await firebaseAuth.signOut();
      return true;
    } catch(e) {
      return false;
    }
  }
  @override
  Future<UserModel?> signInWithGoogle({required GoogleSignInAuthentication googleAuth}) async {
    try {
      UserCredential userCredential = await firebaseAuth.signInWithCredential(
        GoogleAuthProvider.credential(
            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken
        ),
      );
      final user = userCredential.user;
      if (user != null) {
        return UserModel(userUID: user.uid);
      } else {
        return null;
      }
    } catch(e) {
      return null;
    }
  }
  UserModel? _convert2UserModel(User? user) {
    if (user == null) return null;
    return UserModel(userUID: user.uid);
  }

  @override
  Future<UserModel?> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      final user = credential.user;
      if (user != null) {
        return UserModel(userUID: user.uid);
      } else {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return null;
    }
  }

  @override
  Future<UserModel?> signUpWithEmailAndPassword({required String email, required String password}) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      if (user != null) {
        // await dbRepository.saveUserToDb(user.uid);
        return UserModel(userUID: user.uid);
      } else {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
