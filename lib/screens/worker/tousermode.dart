import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:musa3dk/userMode/controllers/JobRequest_controller.dart';
import 'package:musa3dk/userMode/controllers/settingWorker_controller.dart';

class SwitchToUserMode extends StatelessWidget {
  const SwitchToUserMode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => JobRequestControllerImp());
    final controller = Get.put(SettingWorkerControllerImp());
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black45),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "24".tr,
          style: const TextStyle(
              fontFamily: "Inria_Serif",
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FutureBuilder<QuerySnapshot>(
          future: controller.dataUsers
              .where(
                "email",
                isEqualTo: FirebaseAuth.instance.currentUser!.email,
              )
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  const SizedBox(height: 30),
                  FunFormFieldRequest(
                    initialValue: snapshot.data!.docs[0]['name'],
                    labeltext: '25'.tr,
                  ),
                  FunFormFieldRequest(
                    initialValue: snapshot.data!.docs[0]['email'],
                    labeltext: '26'.tr,
                  ),
                  FunFormFieldRequest(
                    initialValue: snapshot.data!.docs[0]['phone'],
                    labeltext: '27'.tr,
                  ),
                  FunFormFieldRequest(
                    initialValue: snapshot.data!.docs[0]['city'],
                    labeltext: '50'.tr,
                  ),
                  const Spacer(),
                  GetBuilder<SettingWorkerControllerImp>(
                    builder: (controller) => MaterialButton(
                        disabledColor: Colors.black12,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 13, horizontal: 50),
                        color: const Color(0xffB99103),
                        textColor: Colors.white,
                        onPressed: () async {
                          controller.updateDatabaseWorker(
                            snapshot.data!.docs[0]['name'],
                            snapshot.data!.docs[0]['email'],
                            snapshot.data!.docs[0]['phone'],
                            snapshot.data!.docs[0]['city'],
                            snapshot.data!.docs[0].id,
                            context,
                          );
                        },
                        child: Text("65".tr,
                            style: const TextStyle(
                                fontFamily: "Inria_Serif",
                                fontWeight: FontWeight.bold,
                                fontSize: 20))),
                  ),
                  const SizedBox(height: 60),
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class FunFormFieldRequest extends StatelessWidget {
  const FunFormFieldRequest({
    Key? key,
    required this.initialValue,
    required this.labeltext,
  }) : super(key: key);
  final String initialValue;
  final String labeltext;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          initialValue: initialValue,
          enabled: false,
          decoration: InputDecoration(
            label: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(labeltext)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
            disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Color(0xffF0D985),
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
          ),
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}
