import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musa3dk/screens/auth/login.dart';
import 'package:musa3dk/screens/auth/verifyEmailPage.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        return Scaffold(
          body: snapshot.data == ConnectivityResult.none
              ? const Center(child: Text("No Internet"))
              : StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return const VerifyEmailPage();
                    } else {
                      return const Login();
                    }
                  },
                ),
        );
      },
    );
  }
}
