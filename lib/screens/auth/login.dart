import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/auth/login_controller.dart';
import '../../core/validinput.dart';
import '../widgets/TextFormField.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LoginControllerImp());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
            child: GetBuilder<LoginControllerImp>(
          builder: (controller) => Form(
            key: controller.formstate,
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  child: Image.asset(
                    "assets/images/logo.png",
                    height: 250,
                    width: 250,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "39".tr,
                      style: const TextStyle(
                          fontFamily: "Inria_Serif",
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "40".tr,
                      style: const TextStyle(
                        fontFamily: "Inria_Serif",
                        fontSize: 18,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                FUNTextFormField(
                  controller: controller.email,
                  labeltext: "26".tr,
                  icon: const Icon(Icons.email_outlined),
                  hinttext: "49".tr,
                  valid: (value) {
                    return validinput(value!, 8, 50, 'email');
                  },
                ),
                FUNTextFormField(
                  keyboard_Type: TextInputType.visiblePassword,
                  controller: controller.password,
                  obsText: controller.isShowPassword,
                  labeltext: "41".tr,
                  icon: const Icon(Icons.lock_outline),
                  hinttext: "42".tr,
                  onTapIcon: () => controller.showPassword(),
                  valid: (value) {
                    return validinput(value!, 6, 20, 'password');
                  },
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                          color: Color.fromRGBO(39, 27, 89, 1),
                          fontFamily: "Inria_Serif",
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                      text: "43".tr,
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              controller.goToSignUp();
                            },
                          text: "45".tr,
                          style: const TextStyle(
                            color: Colors.blueGrey,
                            fontFamily: "Inria_Serif",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                    color: const Color(0xff3A6067),
                    textColor: Colors.white,
                    child: Text("44".tr,
                        style: const TextStyle(
                          fontFamily: "Inria_Serif",
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        )),
                    onPressed: () {
                      controller.login(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
