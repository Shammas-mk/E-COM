import 'dart:async';

import 'package:ecom/helpers/shared_preference.dart';
import 'package:ecom/views/login_page.dart';
import 'package:ecom/views/user_home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/location_controller.dart';
import '../utils/global.dart';
import 'admin_home_page.dart';

class SplashScreen extends StatelessWidget {
  final locationController = Get.put(LocationController());

  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 5), () async {
      String? isLoggedIn = await IdStoring.getId();
      if (isLoggedIn == null) {
        Get.offAll(() => LoginScreen());
      }
      if (isLoggedIn == 'GoogleLogged') {
        Get.offAll(() => HomeScreen());
      }
      if (isLoggedIn == "Admin") {
        Get.offAll(() => const AdminHomePage());
      }
    });

    return Scaffold(
      backgroundColor: Global.mainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "E-COM",
              style: TextStyle(
                  color: Global.logoColor,
                  fontSize: 35,
                  fontWeight: Global.bold),
            ),
            const SizedBox(height: 20),
            CupertinoActivityIndicator(
              radius: 15,
              color: Global.logoColor,
            ),
          ],
        ),
      ),
    );
  }
}
