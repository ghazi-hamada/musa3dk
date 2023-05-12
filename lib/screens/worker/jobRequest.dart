import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:musa3dk/userMode/controllers/JobRequest_controller.dart';

class JobRequest extends StatelessWidget {
  const JobRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => JobRequestControllerImp());
    JobRequestControllerImp controller = Get.put(JobRequestControllerImp());
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xff3A6067)),
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
                  GetBuilder<JobRequestControllerImp>(
                    builder: (controller) => SizedBox(
                      height: 55,
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              label: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Text('28'.tr)),
                              enabledBorder: const OutlineInputBorder(
                                //<-- SEE HERE
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Color(0xffF0D985),
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                //<-- SEE HERE
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2),
                              ),
                              filled: true,
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                icon: const Icon(Icons.arrow_drop_down),
                                hint: Text("29".tr),
                                value: controller.currentSelectedValue,
                                isDense: true,
                                onChanged: (newValue) {
                                  controller.selectedValue(newValue);

                                  print(controller.currentSelectedValue);
                                },
                                items: controller.typeOfJob.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      GetBuilder<JobRequestControllerImp>(
                        builder: (controller) => Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              //select date
                              controller.date(context);
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              foregroundColor: Colors.black,
                              side: const BorderSide(
                                  color: Color(0xffF0D985), width: 2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Text(controller.dateName),
                          ),
                        ),
                      ),
                      const SizedBox(width: 50),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: null,
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            foregroundColor: Colors.black,
                            side: const BorderSide(
                                color: Color(0xffF0D985), width: 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Text(
                            snapshot.data!.docs[0]['city'],
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  GetBuilder<JobRequestControllerImp>(
                    builder: (controller) => MaterialButton(
                        disabledColor: Colors.black12,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 13, horizontal: 50),
                        color: const Color(0xffB99103),
                        textColor: Colors.white,
                        onPressed: controller.enaDate &&
                                controller.currentSelectedValue != null
                            ? () async {
                                controller.updateDatabase(
                                    snapshot.data!.docs[0]['name'],
                                    snapshot.data!.docs[0]['email'],
                                    snapshot.data!.docs[0]['phone'],
                                    controller.currentSelectedValue,
                                    controller.dateName,
                                    snapshot.data!.docs[0]['city'],
                                    snapshot.data!.docs[0].id,
                                    context,
                                    );
                              }
                            : null,
                        child: Text("13".tr,
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
