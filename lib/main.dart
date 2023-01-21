import 'package:dev_edu/client/auth_middleware/auth_middleware.dart';
import 'package:dev_edu/client/landing_page.dart';
import 'package:dev_edu/service/models/user_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthMiddleware(),
      child: MaterialApp(
        title: 'Dev Education',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: const LandingPage(),
      ),
    );
  }
}
