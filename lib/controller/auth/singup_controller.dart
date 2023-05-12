import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:musa3dk/main.dart';
import 'package:musa3dk/screens/widgets/utils.dart';

abstract class SignupController extends GetxController {
  singup(BuildContext context);
  goTologin();
  showPassword();
}

class SignupControllerImp extends SignupController {
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController city;
  late TextEditingController dateBirth;
  late TextEditingController phone;
  late TextEditingController password;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  bool isShowPassword = true;
  @override
  goTologin() {
    Get.offNamed("/");
  }

  @override
  singup(BuildContext context) async {
    final isValid = formstate.currentState!.validate();
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    if (isValid) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text.trim(),
          password: password.text.trim(),
        );
      } on FirebaseAuthException catch (e) {
        Utils.showSnackBar(e.message);
      }

      //add data
      addUserDetails(
        name.text.trim(),
        email.text.trim(),
        city.text.trim(),
        phone.text.trim(),
      );
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
      Get.offAllNamed('/AuthPage');
    }
  }

  Future addUserDetails(  String name, String email, String city, String phone) async {

    await FirebaseFirestore.instance.collection('users').add({
      'city': city,
      'email': email,
      'name': name,
      'phone': phone,
      'accountType': false,
      'rating':0.0
    });
  }
  
  @override
  showPassword() {
    isShowPassword = isShowPassword == true ? false : true;
    update();
  }

  @override
  void onInit() {
    name = TextEditingController();
    email = TextEditingController();
    city = TextEditingController();
    dateBirth = TextEditingController();
    phone = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    super.dispose();
  }
}
