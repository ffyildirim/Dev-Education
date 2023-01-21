import 'package:dev_edu/repository/db_repository.dart';
import 'package:dev_edu/service/models/question_model.dart';
import 'package:dev_edu/service/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'models/score_model.dart';

class DBService {
  DBRepository dbRepository = DBRepository();

  Future<bool> saveUserToDB(UserModel? user) async {
    final response = await dbRepository.saveUserToDb(user);
    return true;
  }

  Future<bool> saveScoreToDB(ScoreModel? score) async{
    await dbRepository.saveScoreToDB(score);
    return true;
  }

  Future<bool> saveQuestionToDB(QuestionModel? question) async{
    await dbRepository.saveQuestionToDB(question);
    return true;
  }

  Future<dynamic> getAllScores(UserModel? user) async {
    final response = await dbRepository.getAllScores(user);
    return response;
  }

  Future<dynamic> getSavedQuestions(UserModel? user) async {
    final response = await dbRepository.getSavedQuestions(user);
    return response;
  }


}
