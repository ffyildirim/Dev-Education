import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_edu/service/models/question_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../service/models/score_model.dart';
import '../service/models/user_model.dart';

class DBRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool> saveUserToDb(UserModel? user) async {
    await firestore
        .collection('users')
        .doc(user?.userUID)
        .set({'name': 'name'})
        .onError((e, _) => print('Error writing document: $e'));
    return true;
  }

  Future<bool> saveScoreToDB(ScoreModel? score) async {
    await firestore
        .collection('users')
        .doc(score?.userUID)
        .collection('previous_quiz')
        .doc()
        .set((score?.toMap())!)
        .onError((e, _) => print('Error writing document: $e')
    );
    return true;
  }

  Future<bool> saveQuestionToDB(QuestionModel? question) async {
    await firestore
        .collection('users')
        .doc(question?.userUID)
        .collection('saved_questions')
        .doc()
        .set((question?.toMap())!)
        .onError((e, _) => print('Error writing document: $e')
    );
    return true;
  }

  Future<dynamic> getAllScores(UserModel? user) async {
    try {
      final response = await firestore
          .collection('users')
          .doc(user?.userUID)
          .collection('previous_quiz')
          .get()
          .then((querySnapshot) {
        List<dynamic> listArray = [];
        for (var doc in querySnapshot.docs) {
          listArray.add(doc.data());
        }
        return listArray;
      });
      return response;
    } catch (e) {
      print('Went something wrong, $e');
      return null;
    }
  }

  Future<dynamic> getSavedQuestions(UserModel? user) async {
    try {
      final response = await firestore
          .collection('users')
          .doc(user?.userUID)
          .collection('saved_questions')
          .get()
          .then((querySnapshot) {
        List<dynamic> listArray = [];
        for (var doc in querySnapshot.docs) {
          listArray.add(doc.data());
        }
        return listArray;
      });
      return response;
    } catch (e) {
      print('Went something wrong, $e');
      return null;
    }
  }
}