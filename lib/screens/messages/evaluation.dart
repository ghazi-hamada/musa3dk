import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:musa3dk/controller/chat/evaluation_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/validinput.dart';

class Evaluation extends StatelessWidget {
  Evaluation({Key? key}) : super(key: key);
  var data = Get.arguments;
  bool isWorker = false;
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => EvaluationControllerImp());
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black45),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: const Text(
            "Customer Evaluation",
            style: TextStyle(
                fontFamily: "Inria_Serif",
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GetBuilder<EvaluationControllerImp>(
              builder: (controller) => FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .where(
                          "email",
                          isEqualTo: data['email'],
                        )
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        isWorker = snapshot.data!.docs[0]['accountType'];
                        return ListView(
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  const SizedBox(height: 35),
                                  !isWorker
                                      ? Image.asset(
                                          "assets/images/image_settings/worker.png",
                                          width: 100,
                                          height: 100,
                                        )
                                      : const Center(
                                          child: Icon(
                                            Icons.person_outline,
                                            size: 90,
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                  const SizedBox(height: 10),
                                  Text(
                                    '${snapshot.data!.docs[0]['name']}',
                                    style: const TextStyle(
                                        fontFamily: "Inria_Serif",
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 55),
                                  RatingBar.builder(
                                    initialRating: 0,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star_sharp,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      controller.changeRating(rating);
                                    },
                                  ),
                                  const SizedBox(height: 55),
                                ],
                              ),
                            ),
                            Form(
                              key: controller.formstate,
                              child: TextFormField(
                                controller: controller.noteController,
                                keyboardType: TextInputType.multiline,
                                maxLines: 6,
                                validator: (value) =>
                                    validinput(value!, 4, 255, 'text'),
                                decoration: InputDecoration(
                                  hintText: "Write your notes...",
                                  fillColor: const Color(0xffF2F2F2),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                      width: 3,
                                      color: !isWorker
                                          ? const Color(0xffF0D985)
                                          : const Color(0xff72DFD0),
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                      width: 3,
                                      color: !isWorker
                                          ? const Color(0xffF0D985)
                                          : const Color(0xff72DFD0),
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                      width: 3,
                                      color: !isWorker
                                          ? const Color(0xffF0D985)
                                          : const Color(0xff72DFD0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                      width: 3,
                                      color: !isWorker
                                          ? const Color(0xffF0D985)
                                          : const Color(0xff72DFD0),
                                    ),
                                  ),
                                ),
                                onChanged: (value) {
                                  controller.changeTextNote(value);
                                },
                              ),
                            ),
                            const SizedBox(height: 25),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 13, horizontal: 50),
                                color: !isWorker
                                    ? const Color(0xffB99103)
                                    : const Color(0xff3A6067),
                                textColor: Colors.white,
                                child: const Text("Send Evaluation",
                                    style: TextStyle(
                                        fontFamily: "Inria_Serif",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                onPressed: () async {
                                  print("************************${snapshot.data!.docs[0]['email']}");
                                  controller.setRating(
                                      snapshot.data!.docs[0].id,
                                      snapshot.data!.docs[0]['rating'],
                                      controller.ratingVal,
                                      controller.note,
                                      snapshot.data!.docs[0]['email'],
                                      data['id'],
                                      context);
                                },
                              ),
                            ),
                          ],
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  )),
        ));
  }
}
