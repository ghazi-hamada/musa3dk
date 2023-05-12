import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/localization/changelocal.dart';
import 'customButtonLang.dart';

class Language extends GetView<LocaleController> {
  const Language({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xff3A6067)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "17".tr,
          style: const TextStyle(
              fontFamily: "Inria_Serif",
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("lang".tr, style: const TextStyle(fontSize: 25)),
            const SizedBox(height: 20),
            buttonLang(
                text: "lanA".tr,
                function: () {
                  controller.changeLang("ar");
                  Get.back();
                }),
            buttonLang(
                text: "lanE".tr,
                function: () {
                  controller.changeLang("en");

                  Get.back();
                }),
          ],
        ),
      ),
    );
  }
}
