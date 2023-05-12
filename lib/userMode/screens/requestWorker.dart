import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:musa3dk/screens/widgets/showStars.dart';

import '../../main.dart';

class RequestWorker extends StatelessWidget {
  RequestWorker({Key? key, required this.id}) : super(key: key);
  final String id;
  var data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xff3CABE6)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "59".tr,
          style: const TextStyle(
              fontFamily: "Inria_Serif",
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('OrdersWorker')
            .where(
              "idOrder",
              isEqualTo: id,
            )
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return WorkerMess(
                  name: snapshot.data!.docs[index]['name'],
                  id: id,
                  isDone: data['isDone'],
                  rating: snapshot.data!.docs[index]['rating'],
                  emailWorker: snapshot.data!.docs[index]['emailWorker'],
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class WorkerMess extends StatelessWidget {
  const WorkerMess({
    super.key,
    required this.name,
    required this.id,
    required this.isDone,
    required this.rating,
    required this.emailWorker,
  });
  final String name;
  final String emailWorker;
  final String id;
  final bool isDone;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            ListTile(
              horizontalTitleGap: 0,
              leading: const Icon(Icons.person),
              title: Text(name),
            ),
            Row(
              children: [
                ShowStars(starsItem: rating),
                const Spacer(),
                MaterialButton(
                  color: const Color(0xff95E7DC),
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    );
                    await FirebaseFirestore.instance
                        .collection('Orders')
                        .doc(id)
                        .update({
                      'isMessaging': true,
                      'workerEmail': emailWorker,
                    });
                    Get.offNamed('/ChatScreen', arguments: {
                      'id': id,
                      'isDone': isDone,
                      'email': emailWorker
                    });
                    navigatorKey.currentState!
                        .popUntil((route) => route.isFirst);
                  },
                  child: Text(
                    '64'.tr,
                    style: const TextStyle(
                        fontFamily: "Inria_Serif", fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              color: const Color(0xff95E7DC),
              height: 1.5,
            )
          ],
        ),
      ),
    );
  }
}
