import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:musa3dk/workerMode/controllers/orderDetailsWorker_controller.dart';
import 'package:musa3dk/userMode/controllers/summary_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderDetailsWorker extends StatelessWidget {
  OrderDetailsWorker({Key? key}) : super(key: key);
  var data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderDetailsWorkerControllerImp());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Text(
          "Summary",
          style: TextStyle(
              fontFamily: "Inria_Serif",
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Image.asset(
              "assets/images/mg.png",
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    "assets/images/hn.png",
                    height: 25,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 9,
                  child: Text(
                    "${data['note']}",
                    style: const TextStyle(
                      fontFamily: "Inria_Serif",
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.clip,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Image.asset(
                  "assets/images/image_order/44.png",
                  height: 25,
                ),
                const SizedBox(width: 10),
                Text(
                  "${data['location'].country} - ${data['location'].administrativeArea} -\n${data['location'].street}",
                  style: const TextStyle(
                    fontFamily: "Inria_Serif",
                    fontSize: 16,
                    color: Color.fromARGB(255, 12, 60, 99),
                  ),
                )
              ],
            ),
            const SizedBox(height: 15),
            Text("${data['title']}"),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      //select date & time
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      foregroundColor: Colors.black,
                      side: const BorderSide(
                        color: Color.fromARGB(255, 88, 212, 195),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    icon: Image.asset(
                      "assets/images/42.png",
                      fit: BoxFit.cover,
                      height: 20,
                    ),
                    label: Text(
                      DateFormat.yMMMMd('en_US').format(data['date']),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      foregroundColor: Colors.black,
                      side: const BorderSide(
                        color: Color.fromARGB(255, 88, 212, 195),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    icon: Image.asset(
                      'assets/images/image_order/49.png',
                      fit: BoxFit.cover,
                      height: 20,
                    ),
                    label: Text("${data['time'].format(context)}"),
                  ),
                ),
              ],
            ),
            const Spacer(),
            FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .where(
                      "email",
                      isEqualTo: FirebaseAuth.instance.currentUser!.email,
                    )
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 13, horizontal: 50),
                          color: const Color(0xff3A6067),
                          textColor: Colors.white,
                          child: const Text("Send Request",
                              style: TextStyle(
                                  fontFamily: "Inria_Serif",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                          onPressed: () async {
                            //
                          },
                        ),
                      ],
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
            const SizedBox(height: 60)
          ],
        ),
      ),
    );
  }
}
