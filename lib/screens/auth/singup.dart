import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musa3dk/screens/widgets/TextFormField.dart';
import 'package:musa3dk/screens/widgets/customButtonAuth.dart';

import '../../controller/auth/singup_controller.dart';
import '../../core/validinput.dart';

class Singup extends StatelessWidget {
  const Singup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SignupControllerImp());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
            child: GetBuilder<SignupControllerImp>(
          builder: (controller) => Form(
            key: controller.formstate,
            child: Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 90),
                      Text(
                        "46".tr,
                        style: const TextStyle(
                            fontFamily: "Inria_Serif",
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "47".tr,
                        style: const TextStyle(
                          fontFamily: "Inria_Serif",
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 50),
                      FUNTextFormField(
                        keyboard_Type: TextInputType.name,
                        controller: controller.name,
                        labeltext: "25".tr,
                        icon: const Icon(Icons.person_outline),
                        hinttext: "48".tr,
                        valid: (value) {
                          return validinput(value!, 8, 50, 'name');
                        },
                      ),
                      FUNTextFormField(
                        keyboard_Type: TextInputType.emailAddress,
                        controller: controller.email,
                        labeltext: "26".tr,
                        icon: const Icon(Icons.email_outlined),
                        hinttext: "49".tr,
                        valid: (value) {
                          return validinput(value!, 8, 50, 'email');
                        },
                      ),
                      FUNTextFormField(
                        keyboard_Type: TextInputType.text,
                        controller: controller.city,
                        labeltext: "50".tr,
                        icon: const Icon(Icons.location_city),
                        hinttext: "51".tr,
                        valid: (value) {
                          return validinput(value!, 3, 50, 'name');
                        },
                      ),
                      FUNTextFormField(
                        keyboard_Type: TextInputType.phone,
                        controller: controller.phone,
                        labeltext: "52".tr,
                        icon: const Icon(Icons.phone),
                        hinttext: "53".tr,
                        valid: (value) {
                          return validinput(value!, 8, 50, 'phone');
                        },
                      ),
                      FUNTextFormField(
                        keyboard_Type: TextInputType.visiblePassword,
                        obsText: controller.isShowPassword,
                        onTapIcon: () => controller.showPassword(),
                        controller: controller.password,
                        labeltext: "41".tr,
                        icon: const Icon(Icons.lock_outline),
                        hinttext: "42".tr,
                        valid: (value) {
                          return validinput(value!, 6, 50, 'password');
                        },
                      ),
                    ],
                  ),
                ),
                customButtonAuth(
                  text: "45".tr,
                  onPress: () {
                    controller.singup(context);
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "54".tr,
                      style: const TextStyle(
                        fontFamily: "Inria_Serif",
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.goTologin();
                      },
                      child: Text(
                        "44".tr,
                        style: const TextStyle(
                            fontFamily: "Inria_Serif",
                            color: Color(0xff3A6067),
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
