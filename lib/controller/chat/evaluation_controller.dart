import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../../screens/widgets/utils.dart';

abstract class EvaluationController extends GetxController {
  changeRating(rating);
  changeTextNote(x);
  Future<void> setRating(
      id, oldRating, newRating, note, email, idOrder, context);
}

class EvaluationControllerImp extends EvaluationController {
  late TextEditingController noteController;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  double ratingVal = 0.0;
  var note = '';
  @override
  void onInit() {
    noteController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  @override
  changeRating(rating) {
    ratingVal = rating;
    update();
  }

  @override
  changeTextNote(x) {
    note = x;
    update();
  }

  @override
  Future<void> setRating(
      id, oldRating, newRating, note, email, idOrder, context) async {
         print('********************************');
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    final isValid = formstate.currentState!.validate();
    if (isValid) {
      try {
        print('********************************');
        await FirebaseFirestore.instance.collection('users').doc(id).update({
          'rating': (oldRating + newRating) / 2,
        }, );

        await FirebaseFirestore.instance.collection("ratings").add({
          'email': email,
          'note': note,
          'rating': newRating,
        });
        await FirebaseFirestore.instance.collection('Orders').doc(idOrder).update({
          'isDone': true,
        }, );
      } on FirebaseFirestore catch (e) {
       Utils.showSnackBar(e.toString());
      }

      update();
    }
    Get.offAllNamed('/AuthPage');
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
