import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';

class VefiryEmailView extends StatefulWidget {
  const VefiryEmailView({super.key});

  @override
  State<VefiryEmailView> createState() => _VefiryEmailViewState();
}

class _VefiryEmailViewState extends State<VefiryEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify email"),
      ),
      body: Column(
        children: [
          const Text(
              "We've sent you an email verifycation. Please open it to verify your email."),
          const Text(
              "If you haven't recievd a verification email yet, press the button below"),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().sendEmailVerification();
            },
            child: const Text(
              'Send email verification',
            ),
          ),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().logOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
            child: const Text('Restart'),
          )
        ],
      ),
    );
  }
}
