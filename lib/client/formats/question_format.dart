import 'package:flutter/material.dart';

class QuestionFormat {
  Widget questions({required int questionIndex, required String questionBody, required String question, required int questionNumber}) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
      child: Column(
        children: [
          Container(
            height: 35,
            alignment: Alignment.topLeft,
            decoration: const BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Center(
              child: Text(
                "Question $questionIndex/$questionNumber",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15, left: 10, right: 10),
            child: Text(
              questionBody,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
            child: Text(
              question,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget stringFormatter(String line) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(child: Text(line)),
    );
  }
}