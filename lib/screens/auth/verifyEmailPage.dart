import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:musa3dk/controller/auth/verifyEmailPage_controller.dart';
import 'package:musa3dk/screens/auth/routerPage.dart';
import 'package:musa3dk/screens/widgets/customButtonAuth.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => VerifyEmailPageControllerImp());
    return GetBuilder<VerifyEmailPageControllerImp>(
      builder: (controller) => controller.isEmailVerified
          ? const RouterPage()
          : Scaffold(
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.white,
                elevation: 0.0,
                actions: [
                  IconButton(
                      onPressed: () async =>
                          await FirebaseAuth.instance.signOut(),
                      icon: const Icon(
                        Icons.logout_outlined,
                        color: Color(0xff3A6067),
                      ))
                ],
              ),
              body: FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .where(
                      "email",
                      isEqualTo: FirebaseAuth.instance.currentUser!.email,
                    )
                    .get(),
                builder: (context, snapshot) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            Image.asset('assets/images/backG.png'),
                            Positioned(
                              bottom: 0,
                              top: 0,
                              right: 0,
                              left: 0,
                              child: Image.asset('assets/images/icon.png'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 70),
                      Text(
                        "61".tr,
                        style: const TextStyle(
                          fontFamily: "Inria_Serif",
                          fontSize: 26,
                        ),
                      ),
                      const SizedBox(height: 22),
                      Center(
                        child: Column(
                          children: [
                            Text(
                              "${'55'.tr} ",
                              style: const TextStyle(
                                  fontFamily: "Inria_Serif",
                                  fontSize: 18,
                                  color: Color(0xff808080)),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.clip,
                            ),
                            snapshot.data != null
                                ? Text(
                                    '${snapshot.data!.docs[0]['email']}.',
                                    style: const TextStyle(
                                        fontFamily: "Inria_Serif",
                                        fontSize: 18,
                                        color: Color(0xff808080)),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                  )
                                : const Text('')
                          ],
                        ),
                      ),
                      const SizedBox(height: 41),
                      customButtonAuth(
                        text: '62'.tr,
                        onPress: () async {
                          controller.launchURL('www.gmail.com');
                        },
                      ),
                    ],
                  ),
                ),
              )),
    );
  }
}
