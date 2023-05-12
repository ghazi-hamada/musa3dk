import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../../screens/widgets/utils.dart';

abstract class LoginController extends GetxController {
  login(BuildContext context);
  goToSignUp();
  showPassword();
}

class LoginControllerImp extends LoginController {
  late TextEditingController email;
  late TextEditingController password;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  bool isShowPassword = true;
  @override
  goToSignUp() {
    Get.offNamed("/Singup");
  }

  @override
  Future login(BuildContext context) async {
    final isValid = formstate.currentState!.validate();
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    if (isValid) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: email.text.trim(),
              password: password.text.trim(),
            )
            .then((UserCredential user) {});
      } on FirebaseAuthException catch (e) {
        Utils.showSnackBar(e.message);
      } on PlatformException catch (e) {
        Utils.showSnackBar(e.message);
      }
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  showPassword() {
    isShowPassword = isShowPassword == true ? false : true;
    update();
  }
}
