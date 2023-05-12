import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('data'),
      onPressed: () => print(FirebaseAuth.instance.currentUser!.uid),
    );
  }
}
