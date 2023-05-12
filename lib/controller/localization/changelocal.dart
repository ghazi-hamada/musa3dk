import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/services.dart';
import 'apptheme.dart';

class LocaleController extends GetxController {
  Locale? language;
  Myservices myservices = Get.find();
  ThemeData appTheme = themeEnglish;
  changeLang(String languageCode) {
    Locale locale = Locale(languageCode);
    myservices.sharedPreferences.setString("lang", languageCode);
    appTheme = languageCode == "ar" ? themeArabic : themeEnglish;
    Get.changeTheme(appTheme);
    Get.updateLocale(locale);
  }

  @override
  void onInit() {
    String? sharedPrefLang = myservices.sharedPreferences.getString("lang");
    if (sharedPrefLang == "ar") {
      language = const Locale("ar");
      appTheme = themeArabic;
    } else if (sharedPrefLang == "en") {
      language = const Locale("en");
      appTheme = themeEnglish;
    } else {
      language = Locale(Get.deviceLocale!.languageCode);
      appTheme = themeEnglish;
    }
    super.onInit();
  }
}
