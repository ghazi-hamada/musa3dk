import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../main.dart';

abstract class DetailsWorkerController extends GetxController {
  accept(
    String nameWorker,
    String id,
    String idWorker,
    double rating,
    String emailworker,
    BuildContext context,
  );
}

class DetailsWorkerControllerImp extends DetailsWorkerController {
  @override
  accept(String nameWorker, String id, String idWorker, double rating,
      String emailworker, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    await FirebaseFirestore.instance.collection('OrdersWorker').add({
      'emailWorker': emailworker,
      'idEmailWorker': idWorker,
      'idOrder': id,
      'rating': rating,
      'name': nameWorker,
    });

    await FirebaseFirestore.instance.collection('Orders').doc(id).set({
      'isEmailWorker': true,
    }, SetOptions(merge: true));
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
    Get.offAllNamed("/RouterPage");
  }
}
