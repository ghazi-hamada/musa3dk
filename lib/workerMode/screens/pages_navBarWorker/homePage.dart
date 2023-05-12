import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:musa3dk/screens/widgets/showStars.dart';
import 'package:musa3dk/screens/worker/detailsWorker.dart';

class HomePageWoker extends StatelessWidget {
  const HomePageWoker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text(
            "1".tr,
            style: const TextStyle(
                fontFamily: "Inria_Serif",
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "60".tr,
                  style: const TextStyle(
                    fontFamily: "Inria_Serif",
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Flexible(
              child: FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("users")
                    .where("email",
                        isEqualTo: FirebaseAuth.instance.currentUser!.email)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return FB2(
                      tyoeOfJob: snapshot.data!.docs[0]['tyoeOfJob'],
                      idEmailWoeker: snapshot.data!.docs[0].id,
                      rating: snapshot.data!.docs[0]['rating'],
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ));
  }
}

class FB2 extends StatefulWidget {
  const FB2({
    super.key,
    required this.tyoeOfJob,
    required this.idEmailWoeker,
    required this.rating,
  });
  final String tyoeOfJob;
  final String idEmailWoeker;
  final double rating;

  @override
  State<FB2> createState() => _FB2State();
}

List<String> idOrders = [];

class _FB2State extends State<FB2> {
  List<String> idAllOrders = [];
  late Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> data;

  @override
  void initState() {
    gdata();
    data = getAllOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
      future: data,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Visibility(
                visible: !idOrders.contains(snapshot.data![index].id),
                child: ListOrder(
                  dataOrder: snapshot.data![index],
                  rating: widget.rating,
                ),
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  bool isExit() {
    for (var element in idAllOrders) {
      idOrders.map((e) {
        if (element == e) {
          return true;
        } else {
          return false;
        }
      });
    }
    return false;
  }

  void gdata() async {
    QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore.instance
        .collection('OrdersWorker')
        .where('idEmailWorker',
            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> listData = data.docs;

    idOrders.clear();

    for (var i = 0; i < listData.length; i++) {
      if (!idOrders.contains(listData[i]['idOrder'])) {
        idOrders.add(listData[i]['idOrder']);
      }
    }
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getAllOrders() async {
    QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore.instance
        .collection('Orders')
        .where('category', isEqualTo: widget.tyoeOfJob)
        .where('isDone', isEqualTo: false)
        .get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> listData = data.docs;

    return listData;
  }
}

class ListOrder extends StatelessWidget {
  const ListOrder({
    Key? key,
    required this.dataOrder,
    required this.rating,
  }) : super(key: key);
  final QueryDocumentSnapshot<Object?> dataOrder;
  final double rating;

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
                  "${dataOrder['name']}",
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
                    flex: 10,
                    child: ListTile(
                      horizontalTitleGap: -9,
                      leading: const Icon(Icons.note_alt_outlined),
                      title: Text(
                        "${dataOrder['note']}",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      textColor: Colors.white,
                      color: const Color(0xffB99103),
                      onPressed: () {
                        Get.to(() => FutureBuilder(
                              future: FirebaseFirestore.instance
                                  .collection('users')
                                  .where(
                                    "email",
                                    isEqualTo: FirebaseAuth
                                        .instance.currentUser!.email,
                                  )
                                  .get(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return DetailsWorker(
                                    note: dataOrder['note'],
                                    locaction: dataOrder['location'],
                                    category: dataOrder['category'],
                                    date: dataOrder['date'],
                                    time: dataOrder['time'],
                                    email: dataOrder['email'],
                                    name: dataOrder['name'],
                                    idWorker:
                                        FirebaseAuth.instance.currentUser!.uid,
                                    emailWorker: snapshot.data!.docs[0]
                                        ['email'],
                                    rating: snapshot.data!.docs[0]['rating'],
                                    nameWorker: snapshot.data!.docs[0]['name'],
                                    id: dataOrder.id,
                                    urlImage: dataOrder['urlImage'],
                                  );
                                }
                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                            ));
                      },
                      child: const Text("Order Details",
                          style: TextStyle(
                              fontSize: 13,
                              fontFamily: "Inria_Serif",
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 5),
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
                  '${dataOrder['location']}',
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
                  '${dataOrder['date']}',
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
                        '${dataOrder['time']}',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  ShowStars(
                    starsItem: double.parse(
                      (rating).toStringAsFixed(1),
                    ),
                  ),
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
