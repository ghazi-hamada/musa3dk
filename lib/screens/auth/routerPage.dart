import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:musa3dk/screens/navBar.dart';
import 'package:musa3dk/screens/worker/navbarWorker.dart';

class RouterPage extends StatelessWidget {
  const RouterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('users')
          .where(
            "email",
            isEqualTo: FirebaseAuth.instance.currentUser!.email,
          )
          .get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.docs[0]['accountType']) {
            return const NavBarWorker();
          }
          return const NavBar();
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
