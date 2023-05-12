import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:musa3dk/workerMode/screens/pages_navBarWorker/homePage.dart';

import '../../../main.dart';

class OrderWorker extends StatelessWidget {
  const OrderWorker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "21".tr,
          style: const TextStyle(
              fontFamily: "Inria_Serif",
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('Orders')
            .where('workerEmail', isEqualTo: "")
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Visibility(
                    visible: idOrders.contains(snapshot.data!.docs[index].id),
                    child: ListOrder(orderData: snapshot.data!.docs[index]));
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class ListOrder extends StatelessWidget {
  const ListOrder({
    Key? key,
    required this.orderData,
  }) : super(key: key);

  final dynamic orderData;
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 180,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: ListTile(
                horizontalTitleGap: -9,
                leading: const Icon(Icons.person_outline),
                title: Text(
                  orderData['name'],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Inria_Serif",
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: ListTile(
                      horizontalTitleGap: -9,
                      leading: const Icon(Icons.note_alt_outlined),
                      title: Text(
                        orderData['note'],
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  orderData['isEmailWorker']
                      ? Expanded(
                          flex: 2,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: const Color(0xff95E7DC),
                            onPressed: () async {
                              Get.toNamed('/ChatScreen', arguments: {
                                'id': orderData.id,
                                'isDone': orderData['isDone'],
                                'email': orderData['email'],
                              });
                            },
                            child: Text(
                              '22'.tr,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Inria_Serif",
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      : Expanded(
                          flex: 5,
                          child: ListTile(
                            horizontalTitleGap: 0,
                            leading: Image.asset(
                              "assets/images/image_order/lod.png",
                              width: 40,
                              height: 40,
                            ),
                            title: Text(
                              "35".tr,
                              style: const TextStyle(
                                fontFamily: "Inria_Serif",
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: ListTile(
                horizontalTitleGap: -9,
                leading: Image.asset(
                  "assets/images/image_order/44.png",
                  height: 25,
                ),
                title: Text(
                  orderData['location'],
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: ListTile(
                horizontalTitleGap: -9,
                leading: Image.asset("assets/images/42.png"),
                title: Text(
                  orderData['date'],
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ListTile(
                      horizontalTitleGap: -9,
                      leading: const Icon(Icons.watch_later_outlined),
                      title: Text(
                        orderData['time'],
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                  const Spacer(),
                  orderData['isDone']
                      ? Row(
                          children: [
                            Image.asset(
                              'assets/images/done.png',
                              height: 15,
                              width: 15,
                            ),
                            const SizedBox(width: 5),
                            Text("36".tr,
                                style: const TextStyle(
                                    fontFamily: "Inria_Serif",
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ],
                        )
                      : Expanded(
                          flex: 1,
                          child: FutureBuilder<QuerySnapshot>(
                            future: FirebaseFirestore.instance
                                .collection('OrdersWorker')
                                .where('emailWorker',
                                    isEqualTo: FirebaseAuth
                                        .instance.currentUser!.email)
                                .where('idOrder', isEqualTo: orderData.id)
                                .get(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  textColor: Colors.white,
                                  color: Colors.red,
                                  onPressed: () async {
                                    print("******************");
                                    showDialog(
                                      context: context,
                                      builder: (context) => const Center(
                                          child: CircularProgressIndicator()),
                                    );
                                    print(
                                        "**************** ${snapshot.data!.docs[0].id}");
                                    delete(snapshot.data!.docs[0].id);
                                    Get.offAllNamed("/RouterPage");
                                    navigatorKey.currentState!
                                        .popUntil((route) => route.isFirst);
                                  },
                                  child: Text(
                                    "37".tr,
                                    style: const TextStyle(
                                      fontFamily: "Inria_Serif",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              }
                              return const Center(child: Text('data'));
                            },
                          ),
                        ),
                  const SizedBox(width: 5),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.black,
            ),
          ],
        ),
      ),
    ));
  }
}

delete(id) async {
  await FirebaseFirestore.instance.collection('OrdersWorker').doc(id).delete();
  print('deleted');
}
