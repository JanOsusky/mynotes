import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
          const Text('Please verify your email adress'),
          TextButton(
              onPressed: () async {
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();
              },
              child: const Text('Send email verification'))
        ],
      ),
    );
  }
}
