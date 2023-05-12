import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:musa3dk/controller/services/services.dart';
import 'package:musa3dk/controller/localization/translation.dart';
import 'package:musa3dk/routes.dart';
import 'package:musa3dk/screens/widgets/utils.dart';
import 'controller/localization/changelocal.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  await Firebase.initializeApp();
  return runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocaleController controller = Get.put(LocaleController());
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: T,
      splitScreenMode: T,
      builder: (context, child) => GetMaterialApp(
        locale: controller.language,
        translations: MyTranslation(),
        scaffoldMessengerKey: Utils.messengerKey,
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blueGrey),
        getPages: routes,
      ),
    );
  }
}
