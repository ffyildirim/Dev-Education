import 'package:dev_edu/client/auth_middleware/auth_middleware.dart';
import 'package:dev_edu/client/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';


class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authMiddleware = Provider.of<AuthMiddleware>(context);
    if (authMiddleware.state == ViewState.idle) {
      if(authMiddleware.user != null) {
        return HomePage(user: authMiddleware.user,);
      } else {
        return const SignInPage();
      }
    } else {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
