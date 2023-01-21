import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int wrongAnswer;
  final int correctAnswer;
  final int questionNumber;

  const Result(
      {Key? key, required this.wrongAnswer, required this.correctAnswer, required this.questionNumber})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Result"),
      ),
      body: Container(
        color: Colors.deepPurple.shade50,
        child: Column(
          children: [
            Container(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width / 8,
                    bottom: 10,
                    left: 12,
                    right: 12),
                color: Colors.blue,
                child: ListTile(
                  leading: Icon(Icons.border_color),
                  title: Text("Number of Questions: $questionNumber"),
                ),
              ),
            ),
            Container(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: EdgeInsets.only(bottom: 10, left: 12, right: 12),
                color: Colors.green,
                child: ListTile(
                  leading: Icon(Icons.check),
                  title: Text("Correct Answer: $correctAnswer"),
                ),
              ),
            ),
            Container(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: EdgeInsets.only(bottom: 10, left: 12, right: 12),
                color: Colors.red,
                child: ListTile(
                  leading: Icon(Icons.cancel),
                  title: Text("Wrong Answer: $wrongAnswer"),
                ),
              ),
            ),
            Container(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: EdgeInsets.only(bottom: 10, left: 12, right: 12),
                color: Colors.grey,
                child: ListTile(
                  leading: Icon(Icons.check_box_outline_blank),
                  title: Text(
                      "Empty: ${questionNumber - (correctAnswer + wrongAnswer)}"),
                ),
              ),
            ),
            Container(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: EdgeInsets.only(bottom: 10, left: 12, right: 12),
                color: Colors.purple,
                child: ListTile(
                  leading: Icon(Icons.trending_up),
                  title: Text(
                      "Score: ${((correctAnswer / questionNumber) * 100).toStringAsFixed(2)}"),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: EdgeInsets.only(bottom: 10, left: 12, right: 12),
                  color: Colors.deepPurple.shade400,
                  child: const ListTile(
                    leading: Icon(Icons.arrow_back),
                    title: Text("Go to Main Page", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}