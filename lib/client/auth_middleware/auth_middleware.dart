import 'package:dev_edu/service/auth_service.dart';
import 'package:dev_edu/service/db_service.dart';
import 'package:dev_edu/service/models/question_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../service/models/score_model.dart';
import '../../service/models/user_model.dart';

enum ViewState { idle, busy }

class AuthMiddleware with ChangeNotifier {
  ViewState _state = ViewState.idle;
  UserModel? _user;
  AuthService authService = AuthService();
  DBService dbService = DBService();

  ViewState get state => _state;
  UserModel? get user => _user;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }
  set user(UserModel? value) {
    _user = value;
    notifyListeners();
  }

  Future<UserModel?> currentUser() async{
    try {
      state = ViewState.idle;
      _user = (await authService.currentUser())!;
      return _user;
    } catch(e) {
      return null;
    }
  }

  Future<void> signInWithGoogle() async {
    state = ViewState.busy;
    try {
      user = await authService.signInWithGoogle();
      state = ViewState.idle;
    } catch(e) {
      state = ViewState.idle;
    }
  }

  Future<void> signInWithEmailAndPassword({ required String email, required String password }) async {
    state = ViewState.busy;
    try {
      user = await authService.signInWithEmailAndPassword(email: email, password: password);
      state = ViewState.idle;
    } catch(e) {
      state = ViewState.idle;
    }
  }

  Future<void> signUpWithEmailAndPassword({ required String email, required String password }) async {
    state = ViewState.busy;
    try {
      user = await authService.signUpWithEmailAndPassword(email: email, password: password);
      await dbService.saveUserToDB(user);
      state = ViewState.idle;
    } catch(e) {
      state = ViewState.idle;
    }
  }

  Future<bool> signOut() async {
    final bool status = await authService.signOut();
    if (status) {
      user = null;
    }
    return status;
  }

  Future <void> saveDataToDatabase() async {
    // final data = dbService.saveDataToDatabase();
  }

  Future<bool> saveScoreToDatabase({ required ScoreModel? score }) async {
    try {
      await dbService.saveScoreToDB(score);
      return true;
    } catch(e) {
      print('Went something wrong $e');
      return false;
    }
  }

  Future<bool> saveQuestionToDatabase({ required QuestionModel? question }) async {
    try {
      await dbService.saveQuestionToDB(question);
      return true;
    } catch(e) {
      print('Went something wrong $e');
      return false;
    }
  }


  Future<dynamic> getAllScoresFromDatabase({ required UserModel? user }) async {
    try {
      final response = await dbService.getAllScores(user);
      return response;
    } catch (e) {
      print('Went something wrong $e');
      return null;
    }
  }

  Future<dynamic> getSavedQuestionsFromDatabase({ required UserModel? user }) async {
    try {
      final response = await dbService.getSavedQuestions(user);
      return response;
    } catch (e) {
      print('Went something wrong $e');
      return null;
    }
  }

}
