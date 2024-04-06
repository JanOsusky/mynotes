import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/utilities/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _passport;

  @override
  void initState() {
    _email = TextEditingController();
    _passport = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _passport.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            decoration: InputDecoration(
              hintText: 'Enter your email here',
            ),
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
          ),
          TextField(
            controller: _passport,
            decoration: InputDecoration(
              hintText: 'Enter your passport here',
            ),
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _passport.text;
              try {
                await AuthService.firebase().createUser(
                  email: email,
                  password: password,
                );
                AuthService.firebase().sendEmailVerification();
                Navigator.of(context).pushNamed(verifyEmailRoute);
              } on WeakPasswordAuthException {
                await showErrorDialog(
                  context,
                  'Weak password, choose diferent!',
                );
              } on EmailAlreadyInUseAuthException {
                await showErrorDialog(
                  context,
                  'Email already in use!',
                );
              } on InvalidEmailAuthException {
                await showErrorDialog(
                  context,
                  'This is an email address!',
                );
              } on GeneralAuthException {
                await showErrorDialog(
                  context,
                  'Failed to register',
                );
              }
            },
            child: const Text('Register'),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  loginRoute,
                  (route) => false,
                );
              },
              child: const Text("Already registered? Login here!"))
        ],
      ),
    );
  }
}
