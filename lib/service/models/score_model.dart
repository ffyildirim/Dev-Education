class ScoreModel {
  final String? userUID;
  final String scorePoint;
  final String? category;
  final String? difficulty;
  final int questionNumber;
  final int correctAns;
  final int wrongAns;
  final int emptyAns;

  ScoreModel({
    required this.userUID,
    required this.category,
    required this.difficulty,
    required this.questionNumber,
    required this.correctAns,
    required this.wrongAns,
    required this.emptyAns,
    required this.scorePoint
  });

  Map<String, dynamic> toMap(){
    return {
      'userUID': userUID,
      'category': category,
      'difficulty': difficulty,
      'questionNumber': questionNumber,
      'correctAns': correctAns,
      'wrongAns': wrongAns,
      'emptyAns': emptyAns,
      'scorePoint': scorePoint,
    };
  }
}
