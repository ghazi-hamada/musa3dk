import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
//

import 'package:path/path.dart';

import '../../screens/widgets/utils.dart';

//
abstract class OrderDetailsController extends GetxController {
  date(BuildContext context);
  time(BuildContext context);
  nextPage(title, imageUrl, location, note, String url, BuildContext context);
}

class OrderDetailsControllerImp extends OrderDetailsController {
  late TextEditingController note;

  GlobalKey<FormState> formstate = GlobalKey();
  DateTime dateTime = DateTime.now();
  DateTime? newdate;
  TimeOfDay? newTime;
  bool enaDate = false;
  bool enaTime = false;
  String dateName = '32'.tr;
  String timeName = '33'.tr;
  String url = "No Image";
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
    dateName = DateFormat.yMd().format(newdate!);
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
    timeName = newTime!.format(context);
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
        await ref.putFile(file!);
        url = await ref.getDownloadURL();
        print("****************$url");
      } else {
        return;
      }
      update();
    } catch (e) {
      print('******************* $e');
    }
  }

  late Reference ref;

  @override
  nextPage(
      title, imageUrl, location, note, String url, BuildContext context) async {
    final isValid = formstate.currentState!.validate();

    if (isValid) {
      showLoading(context);

      Get.toNamed("/Summary", arguments: {
        'title': title,
        'imageUrl': imageUrl,
        'location': location,
        'date': newdate,
        'time': newTime,
        'note': note,
        'url': url,
      });
    }
  }
}
