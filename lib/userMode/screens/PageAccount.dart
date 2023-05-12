import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../screens/widgets/showStarsWidgets.dart';

class PageAccount extends StatelessWidget {
  const PageAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xff3A6067)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "15".tr,
          style: const TextStyle(
              fontFamily: "Inria_Serif",
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        child: Column(
          children: [
            const Center(
              child: Icon(
                Icons.person_outline,
                size: 90,
                color: Colors.blueGrey,
              ),
            ),
            FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .where(
                      "email",
                      isEqualTo: FirebaseAuth.instance.currentUser!.email,
                    )
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        cardAccount(
                          title: snapshot.data!.docs[0]['name'],
                          icon: const Icon(Icons.person_outline),
                        ),
                        cardAccount(
                          title: snapshot.data!.docs[0]['email'],
                          icon: const Icon(Icons.email_outlined),
                        ),
                        cardAccount(
                          title: snapshot.data!.docs[0]['city'],
                          icon: const Icon(Icons.location_on_outlined),
                        ),
                        cardAccount(
                          title: snapshot.data!.docs[0]['phone'],
                          icon: const Icon(Icons.phone),
                        ),
                        ShowStarsWidgets(
                          rating: snapshot.data!.docs[0]['rating'],
                        ),
                      ],
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                })
          ],
        ),
      ),
    );
  }
}

class cardAccount extends StatelessWidget {
  const cardAccount({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);
  final String title;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
            minLeadingWidth: 5,
            minVerticalPadding: 15,
            title: Text(title),
            leading: icon),
        Container(
          color: Colors.black,
          height: 1,
        ),
      ],
    );
  }
}
