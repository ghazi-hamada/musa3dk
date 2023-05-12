import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:get/get.dart';
import '../../workerMode/controllers/navBarWorker_Controller.dart';

class NavBarWorker extends StatelessWidget {
  const NavBarWorker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => NavBarWorkerControllerImp());
    return GetBuilder<NavBarWorkerControllerImp>(
        builder: (controller) => Scaffold(
              bottomNavigationBar: CurvedNavigationBar(
                color: Colors.white,
                backgroundColor: Colors.black12.withOpacity(0.02),
                onTap: (index) {
                  controller.changeIndex(index);
                },
                items: [
                  Image.asset(
                    "assets/images/bottomNav/home.png",
                    height: 32,
                    width: 30,
                  ),
                  Image.asset(
                    "assets/images/bottomNav/lists.png",
                    height: 32,
                    width: 30,
                  ),
                  Image.asset(
                    "assets/images/bottomNav/settings.png",
                    height: 32,
                    width: 30,
                  ),
                ],
              ),
              body: controller.secreen[controller.selectIndex],
            ));
  }
}
