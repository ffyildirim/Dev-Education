import 'package:dev_edu/client/auth_middleware/auth_middleware.dart';
import 'package:dev_edu/client/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String? email;
  String? password;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AuthMiddleware authMiddleware = Provider.of<AuthMiddleware>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dev Education'),
      ),
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Dev Education',
                style: GoogleFonts.lobster(
                    fontWeight: FontWeight.bold, fontSize: 40),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      validator: (validatorVal) {
                        if (!validatorVal!.contains('@')) {
                          return 'Invalid email address';
                        }
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.mail),
                        hintText: 'mail',
                        labelText: 'mail',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (String? value) {
                        email = value;
                      },
                    ),
                    const SizedBox(height: 12.0),
                    TextFormField(
                      obscureText: true,
                      validator: (validatorVal) {
                        if (validatorVal!.length < 6) {
                          return 'Enter at least 6 letters';
                        }
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.password),
                        hintText: 'password',
                        labelText: 'password',
                        border: OutlineInputBorder(),
                      ),
                      onSaved: (String? value) {
                        password = value;
                      },
                    ),
                    const SizedBox(height: 12.0),
                    ElevatedButton(
                      child: const Text('Log in'),
                      onPressed: () {
                        _formKey.currentState?.save();
                        if (email != null && password != null) {
                          authMiddleware.signInWithEmailAndPassword(
                            email: email!,
                            password: password!,
                          );
                        }
                      },
                    ),
                  ],
                ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('images/google_logo.png', height: 30),
                  TextButton(
                    onPressed: () => authMiddleware.signInWithGoogle(),
                    child: const Text(
                      'Continue with Google',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Divider(
                    color: Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Do not have an account?'),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpPage()));
                          },
                          child: const Text('Sign up')),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
