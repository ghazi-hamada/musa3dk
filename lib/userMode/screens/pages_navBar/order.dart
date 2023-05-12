import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:musa3dk/userMode/controllers/order_controller.dart';
import 'package:musa3dk/userMode/screens/requestWorker.dart';

class Order extends StatelessWidget {
  const Order({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
          title:  Text(
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
              .where(
                "email",
                isEqualTo: FirebaseAuth.instance.currentUser!.email,
              )
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return List_order(
                    orderData: snapshot.data!.docs[index],
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}

class List_order extends StatelessWidget {
  const List_order({
    Key? key,
    required this.orderData,
  }) : super(key: key);
  final dynamic orderData;
  

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => OrderControllerImp());
    return GetBuilder<OrderControllerImp>(
        builder: (controller) => SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    height: 180,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: ListTile(
                                  horizontalTitleGap: -9,
                                  leading: const Icon(Icons.work),
                                  title: Row(
                                    children: [
                                      Text(
                                        orderData['category'],
                                        style: const TextStyle(
                                          fontFamily: "Inria_Serif",
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Expanded(flex: 1, child: SizedBox()),
                              orderData['isMessaging']
                                  ? Expanded(
                                      flex: 1,
                                      child: MaterialButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        color: const Color(0xff95E7DC),
                                        onPressed: () async {
                                          Get.toNamed('/ChatScreen',
                                              arguments: {
                                                'id': orderData.id,
                                                'emailWorker':
                                                    orderData['workerEmail'],
                                                'isDone': orderData['isDone'],
                                                'email': orderData['workerEmail'],
                                              });
                                        },
                                        child:  Text(
                                          '22'.tr,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Inria_Serif",
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  : orderData['isEmailWorker']
                                      ? Expanded(
                                          flex: 2,
                                          child: OutlinedButton.icon(
                                            onPressed: () async {
                                              await Get.to(() => RequestWorker(id: orderData.id,
                                              
                                              ),arguments: {
                                                'emailWorker':
                                                    orderData['workerEmail'],
                                                'isDone': orderData['isDone'],
                                                'email': orderData['workerEmail'],
                                              });
                                            },
                                            style: OutlinedButton.styleFrom(
                                              foregroundColor: Colors.black12,
                                              elevation: 7,
                                              backgroundColor: Colors.white,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 5),
                                              side: const BorderSide(
                                                width: 1.5,
                                                color: Color.fromARGB(
                                                    255, 88, 212, 195),
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            icon: Image.asset(
                                              'assets/images/mark.png',
                                              height: 17,
                                            ),
                                            label:  Text(
                                              "23".tr,
                                              style: const TextStyle(
                                                  fontFamily: "Inria_Serif",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  color: Color(0xffFFC048)),
                                            ),
                                          ),
                                        )
                                      : Expanded(
                                          flex: 3,
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                  'assets/images/image_order/lod.png'),
                                              const SizedBox(width: 10),
                                               Text(
                                                "35".tr,
                                                style: const TextStyle(
                                                  fontFamily: "Inria_Serif",
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: ListTile(
                            horizontalTitleGap: -9,
                            leading: const Icon(Icons.note_alt_outlined),
                            title: Text(
                              orderData['note'],
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: ListTile(
                            horizontalTitleGap: -5,
                            leading: Image.asset(
                              "assets/images/image_order/44.png",
                              width: 30,
                              height: 30,
                            ),
                            title: Text(orderData['location'],
                                style: const TextStyle(
                                    fontFamily: "Inria_Serif",
                                    fontSize: 18,
                                    color: Colors.black,
                                    overflow: TextOverflow.ellipsis)),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            horizontalTitleGap: -5,
                            leading: Image.asset(
                              "assets/images/image_order/43.png",
                              width: 30,
                              height: 30,
                            ),
                            title: Text(orderData['date'],
                                style: const TextStyle(
                                  fontFamily: "Inria_Serif",
                                  fontSize: 18,
                                  color: Colors.black,
                                )),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  horizontalTitleGap: -5,
                                  leading: Image.asset(
                                    "assets/images/image_order/49.png",
                                    width: 30,
                                    height: 30,
                                  ),
                                  title: Text(orderData['time'],
                                      style: const TextStyle(
                                        fontFamily: "Inria_Serif",
                                        fontSize: 18,
                                        color: Colors.black,
                                      )),
                                ),
                              ),
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
                                  : SizedBox(
                                      width: 100,
                                      child: MaterialButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        color: const Color.fromARGB(
                                            255, 255, 0, 0),
                                        textColor: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        onPressed: () async {
                                          await controller
                                              .deleteOrder(orderData.id);
                                        },
                                        child:  Text("37".tr),
                                      ),
                                    ),
                              const SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                        ),
                        //Line
                        const Spacer(),
                        Container(
                          color: Colors.green,
                          height: 1,
                        )
                      ],
                    ),
                  )),
            ));
  }
}
