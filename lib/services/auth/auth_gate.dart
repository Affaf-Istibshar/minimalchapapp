//if user is logged in or not
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimalchatapp/services/auth/login_or_register.dart';

import '../../pages/home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        //listening to auth service changes
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user is logged in
          if (snapshot.hasData) {
            return  HomePage();
          }
          //user is not logged in
          else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
