import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../screens/widgets/showStarsWidgets.dart';

class PageAccountWorker extends StatelessWidget {
  PageAccountWorker({Key? key}) : super(key: key);

  CollectionReference noteRef = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xffF0D985)),
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
            Center(
              child: Image.asset(
                "assets/images/image_settings/worker.png",
                width: 100,
                height: 100,
              ),
            ),
            FutureBuilder<QuerySnapshot>(
                future: noteRef
                    .where(
                      "email",
                      isEqualTo: FirebaseAuth.instance.currentUser!.email,
                    )
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        const SizedBox(height: 20),
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
                          title: snapshot.data!.docs[0]['birth'],
                          icon: const Icon(Icons.date_range_outlined),
                        ),
                        cardAccount(
                          title: snapshot.data!.docs[0]['phone'],
                          icon: const Icon(Icons.phone),
                        ),
                        cardAccount(
                          title: snapshot.data!.docs[0]['tyoeOfJob'],
                          icon: const Icon(Icons.work),
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
