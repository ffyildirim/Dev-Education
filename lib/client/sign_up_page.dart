import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'auth_middleware/auth_middleware.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? email;
  String? password;
  final _formKey = GlobalKey<FormState>();

  RegExp passwordValidation = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");

  bool valPassword(String pass){
    if(passwordValidation.hasMatch(pass)) return true;
    else return false;
  }

  @override
  Widget build(BuildContext context) {
    final AuthMiddleware authMiddleware = Provider.of<AuthMiddleware>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Start Your Journey'),
      ),
      body: authMiddleware.state == ViewState.idle ? Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                    validator: (value){
                      if(value!.isEmpty){
                        return "Please enter password";
                      }else{
                        bool result = valPassword(value);
                        if(result){
                          return null;
                        }else{
                          return " Password should include Capital \n small letter & Number & Special";
                        }
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
                    child: const Text('Sign Up'),
                    onPressed: () async {
                      _formKey.currentState?.save();
                      if (email != null && password != null) {
                        await authMiddleware.signUpWithEmailAndPassword(
                          email: email!,
                          password: password!,
                        );
                        if (authMiddleware.user != null) {
                          Navigator.of(context).pop();
                        }
                      }
                    }
                  ),
                ],
              ),
            ),
          ],
        ),
      ) : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
