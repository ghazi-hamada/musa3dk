import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:musa3dk/userMode/controllers/settingWorker_controller.dart';
import 'package:musa3dk/screens/widgets/language.dart';
import '../../../main.dart';
import '../../../screens/widgets/utils.dart';

class SettingWorker extends StatelessWidget {
  const SettingWorker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingWorkerControllerImp());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "14".tr,
          style: const TextStyle(
              fontFamily: "Inria_Serif",
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          cardSettings(
            ontap: () {
              Get.toNamed("/PageAccountWorker");
            },
            title: "15".tr,
            icon: const Icon(Icons.person),
          ),
          cardSettings(
            ontap: () async {
              Get.defaultDialog(
                  title: "57".tr,
                  middleText: "",
                  titleStyle: const TextStyle(fontFamily: "Inria_Serif"),
                  middleTextStyle: const TextStyle(
                      fontFamily: "Inria_Serif", fontWeight: FontWeight.bold),
                  actions: [
                    FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .where(
                            "email",
                            isEqualTo: FirebaseAuth.instance.currentUser!.email,
                          )
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red)),
                            onPressed: () async {
                              Get.toNamed('/SwitchToUserMode');
                              // Get.back();
                            },
                            child: Text(
                              "58".tr,
                            ),
                          );
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black12)),
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        "19".tr,
                      ),
                    ),
                  ]);
            },
            title: "56".tr,
            icon: const Icon(Icons.work),
          ),
          cardSettings(
            ontap: () {
              Get.to(() => const Language());
            },
            title: "17".tr,
            icon: const Icon(Icons.language),
          ),
          cardSettings(
            ontap: () async {
              Get.defaultDialog(
                  title: "20".tr,
                  middleText: "",
                  titleStyle: const TextStyle(fontFamily: "Inria_Serif"),
                  middleTextStyle: const TextStyle(
                      fontFamily: "Inria_Serif", fontWeight: FontWeight.bold),
                  actions: [
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red)),
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        );
                        try {
                          await FirebaseAuth.instance.signOut();
                        } on FirebaseAuthException catch (e) {
                          Utils.showSnackBar(e.message);
                        }
                        navigatorKey.currentState!
                            .popUntil((route) => route.isFirst);
                        Get.back();
                      },
                      child: Text(
                        "18".tr,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        "19".tr,
                      ),
                    ),
                  ]);
            },
            title: "18".tr,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}

class cardSettings extends StatelessWidget {
  const cardSettings({
    Key? key,
    required this.ontap,
    required this.title,
    required this.icon,
  }) : super(key: key);
  final void Function()? ontap;
  final String title;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: ontap,
          child: ListTile(
            leading: icon,
            title: Text(
              title,
              style: const TextStyle(fontFamily: "Inria_Serif", fontSize: 18),
            ),
            trailing: const Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
        Container(
          color: Colors.black,
          height: 1,
        ),
      ],
    );
  }
}
