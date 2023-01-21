import 'dart:convert';

import 'package:dev_edu/client/quiz.dart';
import 'package:dev_edu/client/saved_questions.dart';
import 'package:dev_edu/service/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'PreviousQuizes.dart';
import 'auth_middleware/auth_middleware.dart';

class HomePage extends StatefulWidget {
  final UserModel? user;

  const HomePage({Key? key, this.user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedCategory = 'Docker';
  String? selectedDifficulty = 'Medium';
  List<String> categories = [
    "SQL",
    "Docker",
    "Code",
    "CMS",
    "Linux",
    "DevOps",
    "Bash",
    "Uncategorized",
  ];

  List<String> difficulties = [
    "Easy",
    "Medium",
    "Hard",
  ];

  @override
  void initState() {
    // widget.user?.userUID
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    final authMiddleware = Provider.of<AuthMiddleware>(context);
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text(
                "Dev Education",
                style: TextStyle(fontSize: 22, fontStyle: FontStyle.italic),
              ),
              accountEmail: Text(
                  "berna.kuru@std.ieu.edu.tr\nfurkan.yildirim@std.ieu.edu.tr"),
              // currentAccountPicture: Image.asset("images/appbar_icon.png"),
            ),
            Expanded(
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Api Key'),
                          content: const TextField(
                            decoration: InputDecoration(
                                hintText: 'Enter api key'
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                authMiddleware.saveDataToDatabase();
                                Navigator.of(context).pop();
                              },
                              child: const Text('Submit'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const ListTile(
                      leading: Icon(Icons.key),
                      title: Text('Enter Api Key'),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: Divider(thickness: 1, color: Colors.deepPurple),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PreviousQuizes()),
                      );
                    },
                    child: const ListTile(
                      leading: Icon(Icons.data_thresholding_outlined),
                      title: Text('Previous Quiz Scores'),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: Divider(thickness: 1, color: Colors.deepPurple),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SavedQuestions()),
                      );
                    },
                    child: const ListTile(
                      leading: Icon(Icons.save_alt),
                      title: Text('Saved Questions'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Quiz Settings'),
        actions: <Widget>[
          TextButton(
            onPressed: () => authMiddleware.signOut(),
            child: const Text(
              'sign out',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DecoratedBox(
                  decoration: BoxDecoration(
                      color:Colors.deepPurple.shade300, //background color of dropdown button
                      border: Border.all(color: Colors.black38, width:3), //border of dropdown button
                      borderRadius: BorderRadius.circular(10), //border raiuds of dropdown button
                      boxShadow: const <BoxShadow>[ //apply shadow on Dropdown button
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                            blurRadius: 5) //blur radius of shadow
                      ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left:30, right:30),
                    child: DropdownButton(
                        dropdownColor: Colors.purple.shade50,
                        isExpanded: true,
                        underline: Container(),
                        icon: const Icon(
                          Icons.arrow_drop_down_circle,
                          color: Colors.deepPurple,
                        ),
                        value: selectedCategory,
                        items: categories.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            selectedCategory = value;
                          });
                        }),
                  )
              ),
              const SizedBox(
                height: 20.0,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                    color:Colors.deepPurple.shade300, //background color of dropdown button
                    border: Border.all(color: Colors.black38, width:3), //border of dropdown button
                    borderRadius: BorderRadius.circular(10), //border raiuds of dropdown button
                    boxShadow: const <BoxShadow>[ //apply shadow on Dropdown button
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                          blurRadius: 5) //blur radius of shadow
                    ]
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left:30, right:30),
                  child: DropdownButton(
                      isExpanded: true,
                      icon: const Icon(
                        Icons.arrow_drop_down_circle,
                        color: Colors.deepPurple,
                      ),
                      dropdownColor: Colors.purple.shade50,
                      value: selectedDifficulty,
                      underline: Container(),
                      items: difficulties.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          selectedDifficulty = value;
                        });
                      }),
                )
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: double.infinity,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                    ),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Quiz(selectedCategory: selectedCategory, selectedDifficulty: selectedDifficulty)),
                    ),
                    child: const Text(
                      'Start Quiz',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Row(children: const <Widget>[
                Expanded(
                    child: Divider(
                      color: Colors.black,
                    )),
                Text("  OR  "),
                Expanded(
                    child: Divider(
                      color: Colors.black,
                    )),
              ]),
              const SizedBox(
                height: 30.0,
              ),
              SizedBox(
                width: double.infinity,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Quiz(selectedCategory: null, selectedDifficulty: null)),
                    ),
                    child: const Text(
                      'Start a Random Quiz',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  dynamic readJson() async {
    final String response =
        await rootBundle.loadString('assets/constants/categories.json');
    final data = await json.decode(response);
    return data;
  }

}
