import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leasure_nft/app/admin/screens/admin_main_screen.dart';
import 'package:leasure_nft/app/auth_screens/user_login_screen.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return AdminMainScreen(); // If logged in, go to Dashboard
          } else {
            return UserLoginScreen(); // Otherwise, go to Login
          }
        },
      ),
    );
  }
}
