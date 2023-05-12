import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class SettingWorkerController extends GetxController {
  updateDatabaseWorker(
    String name,
    String email,
    String phone,
    String city,
    String id,
    BuildContext context,
  );
}

class SettingWorkerControllerImp extends SettingWorkerController {
  String dateName = 'Date of birth';
  CollectionReference dataUsers =
      FirebaseFirestore.instance.collection('users');

  @override
  updateDatabaseWorker(String name, String email, String phone, String city,
      String id, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    await FirebaseFirestore.instance.collection('users').doc(id).update({
      'city': city,
      'email': email,
      'name': name,
      'phone': phone,
      'accountType': false,
    });
    Get.offAllNamed("/RouterPage");
  }
}
