import 'package:dev_edu/client/result.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_middleware/auth_middleware.dart';

class PreviousQuizes extends StatefulWidget {
  const PreviousQuizes({Key? key}) : super(key: key);

  @override
  State<PreviousQuizes> createState() => _PreviousQuizesState();
}

class _PreviousQuizesState extends State<PreviousQuizes> {

  @override
  Widget build(BuildContext context) {
    final authMiddleware = Provider.of<AuthMiddleware>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Settings'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
          future: authMiddleware.getAllScoresFromDatabase(user: authMiddleware.user),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<dynamic> jsonList = snapshot.data!;
              return ListView.builder(
                  itemCount: jsonList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        leading: const Icon(Icons.quiz, color: Colors.deepPurple),
                        title: Text('${jsonList[index]['category'] ?? 'Random'} / ${jsonList[index]['difficulty'] ?? 'Random'}'),
                      subtitle: Text('Score: ${jsonList[index]['scorePoint']}'),
                      trailing: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => Result(
                              correctAnswer: jsonList[index]['correctAns'],
                              wrongAnswer: jsonList[index]['wrongAns'],
                              questionNumber: jsonList[index]['questionNumber'],
                            ),
                          ));
                        },
                        child: const Text(
                          'See Details',
                          style: TextStyle(color: Colors.green, fontSize: 15),
                        ),
                      ),
                    );
                  });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      )
    );
  }
}
