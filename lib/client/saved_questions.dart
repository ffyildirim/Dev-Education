import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_middleware/auth_middleware.dart';
import 'formats/answer_format.dart';
import 'formats/question_format.dart';

class SavedQuestions extends StatefulWidget {
  const SavedQuestions({Key? key}) : super(key: key);

  @override
  State<SavedQuestions> createState() => _SavedQuestionsState();
}

class _SavedQuestionsState extends State<SavedQuestions> {
  QuestionFormat questionFormat = QuestionFormat();
  Answers answers = Answers();
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    final authMiddleware = Provider.of<AuthMiddleware>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Questions'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
          future: authMiddleware.getSavedQuestionsFromDatabase(
              user: authMiddleware.user),
          builder: (context, snapshot) {
            List<dynamic>? jsonList = snapshot.data;
            print('data: $jsonList');
            if (snapshot.hasData) {
              if ((jsonList?.isEmpty)!) {
                return const Center(
                  child: Text('No Saved Questions to Show!'),
                );
              } else {
                return Column(
                  children: [
                    Expanded(
                        child: SingleChildScrollView(
                      child: Column(
                        children: [
                          questionFormat.questions(
                              questionIndex: counter + 1,
                              questionBody: "",
                              question: jsonList![counter]['questionText'],
                              questionNumber: jsonList.length),
                          Container(
                            margin: const EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 15.0),
                            child: Column(
                              children: [
                                answers.answer(
                                  jsonList: jsonList, letter: 'a', counter: counter, colorNumber: 0,
                                ),
                                const SizedBox(height: 5),
                                answers.answer(
                                  jsonList: jsonList, letter: 'b', counter: counter, colorNumber: 0,
                                ),
                                const SizedBox(height: 5),
                                answers.answer(
                                  jsonList: jsonList, letter: 'c', counter: counter, colorNumber: 0,
                                ),
                                const SizedBox(height: 5),
                                answers.answer(
                                  jsonList: jsonList, letter: 'd', counter: counter, colorNumber: 0,
                                ),
                                const SizedBox(height: 5),
                                answers.answer(
                                  jsonList: jsonList, letter: 'e', counter: counter, colorNumber: 0,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (counter < jsonList.length - 1)
                                        ++counter;
                                      else {
                                        Navigator.of(context).pop();
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
                                          "Sonraki Soru",
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
}
