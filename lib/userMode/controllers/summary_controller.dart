import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';

abstract class SummaryController extends GetxController {
  Future addSummaryDetails(
    String category,
    String note,
    String location,
    String date,
    String time,
    String name,
    String urlImage,
    BuildContext context
  );
}

class SummaryControllerImp extends SummaryController {
  Future addSummaryDetails(
    String category,
    String note,
    String location,
    String date,
    String time,
    String name,
    String urlImage,
    BuildContext context
  ) async {
     showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    await FirebaseFirestore.instance.collection('Orders').add({
      'isEmailWorker': false, //
      'isMessaging': false, //
      'isDone': false, //
      'name': name, //
      'category': category, //
      'note': note, //
      'location': location, //
      'date': date, //
      'time': time, //
      'email': FirebaseAuth.instance.currentUser!.email, //
      'workerEmail': '',
      'urlImage': urlImage,
    });
       navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
