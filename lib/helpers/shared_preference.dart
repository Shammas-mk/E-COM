import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../views/splash_page.dart';

class IdStoring {
  static SharedPreferences? preferences;

  static Future init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static Future setId(id) async {
    print("+++++++++++++++++++++++++++ set id function $id");
    await preferences!.setString("id", id);
  }

  static Future getId() async {
    return preferences!.getString("id");
  }

  //

  static Future logout() async {
    await preferences!.clear();
    Get.deleteAll();
    Get.offAll(() => SplashScreen());
  }
}
