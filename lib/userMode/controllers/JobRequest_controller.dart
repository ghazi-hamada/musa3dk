import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../main.dart';

abstract class JobRequestController extends GetxController {
  selectedValue(newValue);
  date(BuildContext context);
  updateDatabase(
    String name,
    String email,
    String phone,
    String tyoeOfJob,
    String date,
    String city,
    String id,
    BuildContext context,
  );
}

class JobRequestControllerImp extends JobRequestController {
  bool enaDate = false;
  var currentSelectedValue;
  String dateName = '30'.tr;
  CollectionReference dataUsers =
      FirebaseFirestore.instance.collection('users');
  DateTime dateTime = DateTime.now();
  DateTime? newdate;
  List<String> typeOfJob = [
    'Carpentry',
    'Plumbing',
    'Electricity',
    'Satellite',
    'Paints',
    'Flooring'
  ];

  @override
  selectedValue(newValue) {
    currentSelectedValue = newValue;
    update();
  }

  @override
  date(BuildContext context) async {
    newdate = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(1995),
      lastDate: DateTime(2024),
    );
    if (newdate == null) {
      return;
    }
    dateName = DateFormat.yMd().format(newdate!);
    print(dateName);
    enaDate = true;
    update();
  }

  @override
  updateDatabase(String name, String email, String phone, String tyoeOfJob,
      String date, String city, String id, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    await FirebaseFirestore.instance.collection('users').doc(id).update({
      'rating': 0.0,
      'city': city,
      'email': email,
      'name': name,
      'phone': phone,
      'tyoeOfJob': tyoeOfJob,
      'birth': date,
      'accountType': true,
    });
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
    Get.offAllNamed("/RouterPage");
  }
}
