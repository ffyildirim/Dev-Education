
class AnswerModel {
  final String? answerA;
  final String? answerB;
  final String? answerC;
  final String? answerD;
  final String? answerE;

  AnswerModel({
    required this.answerA,
    required this.answerB,
    required this.answerC,
    required this.answerD,
    required this.answerE,
  });

  Map<String, dynamic> toMap(){
    return {
      'answer_a': answerA,
      'answer_b': answerB,
      'answer_c': answerC,
      'answer_d': answerD,
      'answer_e': answerE,
    };
  }

}

class QuestionModel {
  final String? userUID;
  final String questionText;
  final AnswerModel answers;

  QuestionModel({
    required this.userUID,
    required this.questionText,
    required this.answers,
  });

  Map<String, dynamic> toMap(){
    return {
      'userUID': userUID,
      'questionText': questionText,
      'answers': answers.toMap(),
    };
  }

}