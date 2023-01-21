import 'dart:convert';
import 'package:dev_edu/client/formats/answer_format.dart';
import 'package:dev_edu/client/formats/question_format.dart';
import 'package:dev_edu/client/result.dart';
import 'package:dev_edu/service/models/question_model.dart';
import 'package:dev_edu/service/models/score_model.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'auth_middleware/auth_middleware.dart';

class Quiz extends StatefulWidget {
  const Quiz(
      {Key? key,
      required this.selectedCategory,
      required this.selectedDifficulty})
      : super(key: key);

  final String? selectedCategory;
  final String? selectedDifficulty;

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  QuestionFormat questionFormat = QuestionFormat();
  Answers answers = Answers();
  int counter = 0;
  int colora = 0;
  int colorb = 0;
  int colorc = 0;
  int colord = 0;
  int colore = 0;
  int counterClick = 0;
  int correctAnswer = 0;
  int wrongAnswer = 0;
  int totalQuestion = 0;
  Future<List?>? jsonList = null;

  @override
  void initState() {
    super.initState();
    jsonList = _getQuestions();
  }

  @override
  Widget build(BuildContext context) {
    final authMiddleware = Provider.of<AuthMiddleware>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.selectedCategory ?? 'Random'} Questions'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
          future: jsonList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List jsonList = snapshot.data!;
              if (jsonList[0]['error'] == null) {
                totalQuestion = jsonList.length;
                return Column(
                  children: [
                    Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(15.0),
                                    padding: const EdgeInsets.all(3.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        border: Border.all(color: Colors.deepPurple)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15.0, horizontal: 40.0),
                                      child: Text(
                                        widget.selectedCategory != null ? widget.selectedCategory! : 'Random',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(15.0),
                                    padding: const EdgeInsets.all(3.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                        border: Border.all(color: Colors.deepPurple)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15.0, horizontal: 40.0),
                                      child: Text(
                                        widget.selectedDifficulty != null ? widget.selectedDifficulty! : 'Random',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              questionFormat.questions(
                                  questionIndex: counter + 1,
                                  questionBody: "",
                                  question: jsonList[counter]['question'],
                                  questionNumber: totalQuestion),
                              Container(
                                margin: const EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 15.0),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (counterClick > 0) {
                                            if (jsonList[counter]['correct_answers']['answer_b_correct'] == 'true')
                                              colorb = 2;
                                            else if (jsonList[counter]['correct_answers']['answer_c_correct'] == 'true')
                                              colorc = 2;
                                            else if (jsonList[counter]['correct_answers']['answer_d_correct'] == 'true')
                                              colord = 2;
                                            else if (jsonList[counter]['correct_answers']['answer_e_correct'] == 'true')
                                              colore = 2;
                                          } else {
                                            if (jsonList[counter]['correct_answers']['answer_a_correct'] == "false") {
                                              wrongAnswer++;
                                              colora = 1;
                                              if (jsonList[counter]['correct_answers']['answer_b_correct'] == 'true')
                                                colorb = 2;
                                              else if (jsonList[counter]['correct_answers']['answer_c_correct'] == 'true')
                                                colorc = 2;
                                              else if (jsonList[counter]['correct_answers']['answer_d_correct'] == 'true')
                                                colord = 2;
                                              else if (jsonList[counter]['correct_answers']['answer_e_correct'] == 'true')
                                                colore = 2;
                                              counterClick++;
                                            }
                                            if (jsonList[counter]['correct_answers']['answer_a_correct'] == "true") {
                                              colora = 2;
                                              counterClick++;
                                              correctAnswer++;
                                            }
                                          }
                                        });
                                      },
                                      child: answers.answer(
                                        jsonList: jsonList, letter: 'a', counter: counter, colorNumber: colora,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (counterClick > 0) {
                                            if (jsonList[counter]['correct_answers']['answer_a_correct'] == 'true')
                                              colora = 2;
                                            else if (jsonList[counter]['correct_answers']['answer_c_correct'] == 'true')
                                              colorc = 2;
                                            else if (jsonList[counter]['correct_answers']['answer_d_correct'] == 'true')
                                              colord = 2;
                                            else if (jsonList[counter]['correct_answers']['answer_e_correct'] == 'true')
                                              colore = 2;
                                          } else {
                                            if (jsonList[counter]['correct_answers']['answer_b_correct'] == "false") {
                                              wrongAnswer++;
                                              colorb = 1;
                                              if (jsonList[counter]['correct_answers']['answer_a_correct'] == 'true')
                                                colora = 2;
                                              else if (jsonList[counter]['correct_answers']['answer_c_correct'] == 'true')
                                                colorc = 2;
                                              else if (jsonList[counter]['correct_answers']['answer_d_correct'] == 'true')
                                                colord = 2;
                                              else if (jsonList[counter]['correct_answers']['answer_e_correct'] == 'true')
                                                colore = 2;
                                              counterClick++;
                                            }
                                            if (jsonList[counter]['correct_answers']['answer_b_correct'] == "true") {
                                              colorb = 2;
                                              counterClick++;
                                              correctAnswer++;
                                            }
                                          }
                                        });
                                      },
                                      child: answers.answer(
                                        jsonList: jsonList, letter: 'b', counter: counter, colorNumber: colorb,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (counterClick > 0) {
                                            if (jsonList[counter]['correct_answers']['answer_a_correct'] == 'true')
                                              colora = 2;
                                            else if (jsonList[counter]['correct_answers']['answer_b_correct'] == 'true')
                                              colorb = 2;
                                            else if (jsonList[counter]['correct_answers']['answer_d_correct'] == 'true')
                                              colord = 2;
                                            else if (jsonList[counter]['correct_answers']['answer_e_correct'] == 'true')
                                              colore = 2;
                                          } else {
                                            if (jsonList[counter]['correct_answers']['answer_c_correct'] == "false") {
                                              wrongAnswer++;
                                              colorc = 1;
                                              if (jsonList[counter]['correct_answers']['answer_a_correct'] == 'true')
                                                colora = 2;
                                              else if (jsonList[counter]['correct_answers']['answer_b_correct'] == 'true')
                                                colorb = 2;
                                              else if (jsonList[counter]['correct_answers']['answer_d_correct'] == 'true')
                                                colord = 2;
                                              else if (jsonList[counter]['correct_answers']['answer_e_correct'] == 'true')
                                                colore = 2;
                                              counterClick++;
                                            }
                                            if (jsonList[counter]['correct_answers']['answer_c_correct'] == "true") {
                                              colorc = 2;
                                              counterClick++;
                                              correctAnswer++;
                                            }
                                          }
                                        });
                                      },
                                      child: answers.answer(
                                        jsonList: jsonList, letter: 'c', counter: counter, colorNumber: colorc,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (counterClick > 0) {
                                            if (jsonList[counter]['correct_answers']['answer_a_correct'] == 'true')
                                              colora = 2;
                                            else if (jsonList[counter]['correct_answers']['answer_b_correct'] == 'true')
                                              colorb = 2;
                                            else if (jsonList[counter]['correct_answers']['answer_c_correct'] == 'true')
                                              colorc = 2;
                                            else if (jsonList[counter]['correct_answers']['answer_e_correct'] == 'true')
                                              colore = 2;
                                          } else {
                                            if (jsonList[counter]['correct_answers']['answer_d_correct'] == "false") {
                                              wrongAnswer++;
                                              colord = 1;
                                              if (jsonList[counter]['correct_answers']['answer_a_correct'] == 'true')
                                                colora = 2;
                                              else if (jsonList[counter]['correct_answers']['answer_b_correct'] == 'true')
                                                colorb = 2;
                                              else if (jsonList[counter]['correct_answers']['answer_c_correct'] == 'true')
                                                colorc = 2;
                                              else if (jsonList[counter]['correct_answers']['answer_e_correct'] == 'true')
                                                colore = 2;
                                              counterClick++;
                                            }
                                            if (jsonList[counter]['correct_answers']['answer_d_correct'] == "true") {
                                              colord = 2;
                                              counterClick++;
                                              correctAnswer++;
                                            }
                                          }
                                        });
                                      },
                                      child: answers.answer(
                                        jsonList: jsonList, letter: 'd', counter: counter, colorNumber: colord,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (counterClick > 0) {
                                            if (jsonList[counter]['correct_answers']['answer_a_correct'] == 'true')
                                              colora = 2;
                                            else if (jsonList[counter]['correct_answers']['answer_b_correct'] == 'true')
                                              colorb = 2;
                                            else if (jsonList[counter]['correct_answers']['answer_c_correct'] == 'true')
                                              colorc = 2;
                                            else if (jsonList[counter]['correct_answers']['answer_d_correct'] == 'true')
                                              colord = 2;
                                          } else {
                                            if (jsonList[counter]['correct_answers']['answer_e_correct'] == "false") {
                                              wrongAnswer++;
                                              colore = 1;
                                              if (jsonList[counter]['correct_answers']['answer_a_correct'] == 'true')
                                                colora = 2;
                                              else if (jsonList[counter]['correct_answers']['answer_b_correct'] == 'true')
                                                colorb = 2;
                                              else if (jsonList[counter]['correct_answers']['answer_c_correct'] == 'true')
                                                colorc = 2;
                                              else if (jsonList[counter]['correct_answers']['answer_d_correct'] == 'true')
                                                colord = 2;
                                              counterClick++;
                                            }
                                            if (jsonList[counter]['correct_answers']['answer_e_correct'] == "true") {
                                              colore = 2;
                                              counterClick++;
                                              correctAnswer++;
                                            }
                                          }
                                        });
                                      },
                                      child: answers.answer(
                                        jsonList: jsonList, letter: 'e', counter: counter, colorNumber: colore,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          colora = 0;
                                          colorb = 0;
                                          colorc = 0;
                                          colord = 0;
                                          colore = 0;
                                          counterClick = 0;
                                          if (counter < totalQuestion - 1)
                                            ++counter;
                                          else {
                                            ScoreModel scoreModel = ScoreModel(
                                              category: widget.selectedCategory,
                                              difficulty: widget.selectedDifficulty,
                                              questionNumber: totalQuestion,
                                              correctAns: correctAnswer,
                                              wrongAns: wrongAnswer,
                                              emptyAns: totalQuestion - (correctAnswer + wrongAnswer),
                                              scorePoint: ((correctAnswer / totalQuestion) * 100).toStringAsFixed(2),
                                              userUID: authMiddleware.user?.userUID,
                                            );
                                            authMiddleware.saveScoreToDatabase(score: scoreModel);
                                            Navigator.of(context)
                                                .pushReplacement(MaterialPageRoute(
                                              builder: (context) => Result(
                                                correctAnswer: correctAnswer,
                                                wrongAnswer: wrongAnswer,
                                                questionNumber: totalQuestion,
                                              ),
                                            ));
                                          }
                                        });
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        margin: const EdgeInsets.only(
                                            bottom: 10, left: 12, right: 12),
                                        color: Colors.deepPurple,
                                        child: const ListTile(
                                          trailing: Icon(Icons.arrow_forward),
                                          title: Center(
                                            child: Text(
                                              "Next Question",
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        AnswerModel answerModel = AnswerModel(
                                            answerA: jsonList[counter]['answers']['answer_a'],
                                            answerB: jsonList[counter]['answers']['answer_b'],
                                            answerC: jsonList[counter]['answers']['answer_c'],
                                            answerD: jsonList[counter]['answers']['answer_d'],
                                            answerE: jsonList[counter]['answers']['answer_e'],
                                        );
                                        QuestionModel questionModel = QuestionModel(
                                          userUID: authMiddleware.user?.userUID,
                                          questionText: jsonList[counter]['question'],
                                            answers: answerModel,
                                        );
                                        final response = await authMiddleware.saveQuestionToDatabase(question: questionModel);
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: response == true ? const Text('Success') : const Text('Failed'),
                                            content: response == true ? const Text('Question Saved') : const Text('Question is not Saved'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Okay'),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        margin: const EdgeInsets.only(
                                            bottom: 10, left: 12, right: 12),
                                        color: Colors.green.shade600,
                                        child: const ListTile(
                                          trailing: Icon(Icons.save),
                                          title: Center(
                                            child: Text(
                                              "Save Question",
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ))
                  ],
                );
              } else {
                return Center(
                  child: Text(jsonList[0]['error'], style: TextStyle(fontWeight: FontWeight.bold),),
                );
              }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Future<List?> _getQuestions() async {
    final queryParameters = {
      if(widget.selectedCategory != null) 'category': widget.selectedCategory,
      if(widget.selectedDifficulty != null) 'difficulty': widget.selectedDifficulty,
      'apiKey': 'PeH4sotW6WqxVpgCzRPmetEluO0AFEqb1o7WLGXd',
      'limit': '20',
    };
    try {
      // https://quizapi.io/api/v1/questions?limit=20&tags=BASH
      Uri url = Uri.https('quizapi.io', '/api/v1/questions', queryParameters);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        dynamic jsonResponse = json.decode(response.body) as List<dynamic>;
        return jsonResponse;
      } else {
        dynamic jsonResponse = json.decode(response.body);
        return [jsonResponse];
      }
      return null;
    } catch (e) {
      print("hata -> $e");
    }
  }
}
