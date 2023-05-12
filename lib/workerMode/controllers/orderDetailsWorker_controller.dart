import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
//

import 'package:path/path.dart';

//
abstract class OrderDetailsWorkerController extends GetxController {
  date(BuildContext context);
  time(BuildContext context);
}

class OrderDetailsWorkerControllerImp extends OrderDetailsWorkerController {
  late TextEditingController note;
  
  GlobalKey<FormState> formstate = GlobalKey();
  DateTime dateTime = DateTime.now();
  DateTime? newdate;
  TimeOfDay? newTime;
  bool enaDate = false;
  bool enaTime = false;
  @override
  date(BuildContext context) async {
    newdate = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );
    if (newdate == null) {
      return;
    }
    update();
  }

  @override
  time(BuildContext context) async {
    newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: dateTime.hour,
        minute: dateTime.minute,
      ),
    );
    if (newTime == null) {
      return;
    }
    update();
  }

  @override
  void onInit() {
    note = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    note.dispose();
    super.dispose();
  }

  File? file;

  Future pickImageCamera(BuildContext context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    try {
      if (image != null) {
        file = File(image.path);
        var rend = Random().nextInt(1000000);
        var imageName = '$rend${basename(image.path)}';
        ref = FirebaseStorage.instance.ref('images').child(imageName);
        print("****************$imageName");
      } else {
        return;
      }
    } catch (e) {
      print('******************* $e');
    }
  }

  var ref;
}
/*
   @override
  datePicker(BuildContext context) async {
    DateTime? newdate = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );
    if (newdate == null) {
      return;
    }
    TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: dateTime.hour,
        minute: dateTime.minute,
      ),
    );
    if (newTime == null) {
      return;
    }

    final newDateTime = DateTime(
      newdate.year,
      newdate.month,
      newdate.day,
      newTime.hour,
      newTime.minute,
    );

    dateTime = newDateTime;
    update();
  }
 */