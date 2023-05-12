import 'package:get/get.dart';

import '../screens/pages_navBar/homePage.dart';
import '../screens/pages_navBar/order.dart';
import '../screens/pages_navBar/setting.dart';

abstract class NavBarController extends GetxController {
  changeIndex(int index);
}

class NavBarControllerImp extends NavBarController {
  int selectIndex = 0;
  List secreen = [const HomePage(), const Order(), const Setting()];
  @override
  changeIndex(int index) {
    selectIndex = index;
    update();
  }
}
