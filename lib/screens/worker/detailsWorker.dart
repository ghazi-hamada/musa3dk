import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musa3dk/userMode/controllers/detailsWorker_contoller.dart';

class DetailsWorker extends StatelessWidget {
  const DetailsWorker({
    Key? key,
    required this.note,
    required this.locaction,
    required this.category,
    required this.date,
    required this.time,
    required this.email,
    required this.id,
    required this.name,
    required this.idWorker,
    required this.rating,
    required this.nameWorker,
    required this.emailWorker,
    required this.urlImage,
  }) : super(key: key);

  final String note;
  final String locaction;
  final String category;
  final String date;
  final String time;
  final String email;
  final String id;
  final String idWorker;
  final String name;
  final String nameWorker;
  final String emailWorker;
  final String urlImage;
  final double rating;
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DetailsWorkerControllerImp());
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xffB99103)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Text(
          "Order Details",
          style: TextStyle(
              fontFamily: "Inria_Serif",
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: orderList(
        note: note,
        locaction: locaction,
        category: category,
        date: date,
        time: time,
        name: name,
        email: email,
        id: id,
        idWorker: idWorker,
        rating: rating,
        nameWorker: nameWorker,
        emailWorker: emailWorker,
        urlImage: urlImage,
      ),
    );
  }
}

class orderList extends StatelessWidget {
  const orderList({
    super.key,
    required this.note,
    required this.locaction,
    required this.category,
    required this.date,
    required this.time,
    required this.name,
    required this.email,
    required this.id,
    required this.idWorker,
    required this.rating,
    required this.nameWorker,
    required this.emailWorker,
    required this.urlImage,
  });

  final String note;
  final String locaction;
  final String category;
  final String date;
  final String time;
  final String name;
  final String nameWorker;
  final String email;
  final String id;
  final String idWorker;
  final String emailWorker;
  final double rating;
  final String urlImage;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          urlImage != 'No Image'
              ? Image.network(
                  urlImage,
                  width: 320,
                  height: 255,
                )
              : Text(
                  urlImage,
                  style: const TextStyle(
                    fontFamily: "Inria_Serif",
                    fontSize: 16,
                    color: Colors.black,
                  ),
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
                  note,
                  style: const TextStyle(
                    fontFamily: "Inria_Serif",
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.clip,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Image.asset(
                  "assets/images/image_order/44.png",
                  height: 25,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 9,
                child: Text(
                  locaction,
                  style: const TextStyle(
                    fontFamily: "Inria_Serif",
                    fontSize: 16,
                    color: Color.fromARGB(255, 12, 60, 99),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
                onPressed: null,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  foregroundColor: Colors.black,
                  side: const BorderSide(color: Color(0xffF0D985)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text(
                  category,
                  style: const TextStyle(color: Colors.black),
                )),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: null,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    foregroundColor: Colors.black,
                    side: const BorderSide(
                      color: Color(0xffF0D985),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  icon: Image.asset(
                    "assets/images/42.png",
                    fit: BoxFit.cover,
                    height: 20,
                  ),
                  label: Text(
                    date,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: null,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    foregroundColor: Colors.black,
                    side: const BorderSide(
                      color: Color(0xffF0D985),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  icon: Image.asset(
                    'assets/images/image_order/49.png',
                    fit: BoxFit.cover,
                    height: 20,
                  ),
                  label: Text(
                    time,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          GetBuilder<DetailsWorkerControllerImp>(
            builder: (controller) => MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              textColor: Colors.white,
              color: const Color(0xffB99103),
              onPressed: () {
                controller.accept(
                  nameWorker, //
                  id, //
                  idWorker, //
                  rating,
                  emailWorker,
                  context
                );
              },
              child: Text("63".tr,
                  style: const TextStyle(
                      fontFamily: "Inria_Serif", fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(
            height: 60,
          )
        ],
      ),
    );
  }
}
