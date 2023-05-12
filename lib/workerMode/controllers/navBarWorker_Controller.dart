import 'package:get/get.dart';
import 'package:musa3dk/workerMode/screens/pages_navBarWorker/homePage.dart';
import 'package:musa3dk/workerMode/screens/pages_navBarWorker/order.dart';
import 'package:musa3dk/workerMode/screens/pages_navBarWorker/setting.dart';

abstract class NavBarWorkerController extends GetxController {
  changeIndex(int index);
}

class NavBarWorkerControllerImp extends NavBarWorkerController {
  int selectIndex = 0;
  List secreen = [ HomePageWoker(), const OrderWorker(), const SettingWorker()];
  @override
  changeIndex(int index) {
    selectIndex = index;
    update();
  }
}
