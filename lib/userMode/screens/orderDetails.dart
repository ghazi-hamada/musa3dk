import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:musa3dk/userMode/controllers/googleMap_controller.dart';
import 'package:musa3dk/userMode/controllers/orderDetails_controller.dart';
import 'package:musa3dk/core/validinput.dart';

class OrderDetails extends StatelessWidget {
  OrderDetails({Key? key}) : super(key: key);
  var data = Get.arguments;
  String note = '';
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => OrderDetailsControllerImp());
    GoogleMapsControllerImp getController = Get.put(GoogleMapsControllerImp());
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black45),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "11".tr,
          style: const TextStyle(
              fontFamily: "Inria_Serif",
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: GetBuilder<OrderDetailsControllerImp>(
            builder: (controller) => Column(
              children: [
                Form(
                    key: controller.formstate,
                    child: Stack(
                      children: [
                        TextFormField(
                          controller: controller.note,
                          keyboardType: TextInputType.multiline,
                          maxLines: 6,
                          validator: (value) =>
                              validinput(value!, 10, 255, 'text'),
                          decoration: InputDecoration(
                            hintText: "31".tr,
                            fillColor: const Color.fromARGB(255, 204, 204, 204),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: Color(0xff72dfd0),
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            note = value;
                          },
                        ),
                        Positioned(
                            right: 0,
                            bottom: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                  onPressed: () {
                                    controller.pickImageCamera(context);
                                  },
                                  icon: Image.asset("assets/images/22.png")),
                            ))
                      ],
                    )),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          //select date
                          controller.enaDate = true;
                          controller.date(context);
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
                        label: Text(controller.dateName),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          controller.enaTime = true;
                          controller.time(context);
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
                          "assets/images/image_order/49.png",
                          fit: BoxFit.cover,
                          height: 20,
                        ),
                        label: Text(controller.timeName),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                MaterialButton(
                  disabledColor: Colors.black12,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 13, horizontal: 50),
                  color: const Color(0xff3A6067),
                  textColor: Colors.white,
                  onPressed: controller.enaDate && controller.enaTime
                      // ignore: avoid_print
                      ? () async {
                          List<Placemark> placemarks =
                              await placemarkFromCoordinates(
                            data['locationLat'],
                            data['locationLong'],
                          );
                          // ignore: use_build_context_synchronously
                          controller.nextPage(
                            data['title'],
                            data['imageUrl'],
                            placemarks[0],
                            note,
                            // ignore: prefer_if_null_operators
                            controller.url,
                            context,
                          );
                        }
                      : null,
                  child: Text("34".tr,
                      style: const TextStyle(
                          fontFamily: "Inria_Serif",
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                ),
                const SizedBox(height: 60)
              ],
            ),
          )),
    );
  }
}
