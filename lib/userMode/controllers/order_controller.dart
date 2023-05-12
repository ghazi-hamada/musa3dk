import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


abstract class OrderController extends GetxController {
  Future deleteOrder(id);
}

class OrderControllerImp extends OrderController {
  @override
  Future<void> deleteOrder(id) async{
   await Get.defaultDialog(
                  title: "Do you want to cancel order?",
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
                        await  FirebaseFirestore.instance.collection('Orders').doc(id).delete();
                        Get.back();
                      },
                      child: const Text(
                        "yes",
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text(
                        "no",
                      ),
                    ),
                  ]);
  
    update();
    Get.offAllNamed('/AuthPage');
  }
}
