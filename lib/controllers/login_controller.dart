import 'dart:async';
import 'package:ecom/helpers/shared_preference.dart';
import 'package:ecom/views/splash_page.dart';
import 'package:ecom/views/user_home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../utils/global.dart';

class LoginController extends GetxController {
  final _googleSignIn = GoogleSignIn();
  var googleAccount = Rx<GoogleSignInAccount?>(null);

  googleLogin() async {
    googleAccount.value = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleAccount.value!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    if (googleAccount.value != null) {
      Get.offAll(() => HomeScreen());
    }
    update();
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  googleLogout(context) async {
    googleAccount.value = await _googleSignIn.signOut();
    IdStoring.logout();
    await Get.offAll(() => SplashScreen());
  }

  errorSnackBar(title, subTitle) {
    Get.snackbar(
      title,
      subTitle,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(10),
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  successSnackBar(title, subTitle) {
    Get.snackbar(
      title,
      subTitle,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(10),
      backgroundColor: Global.mainColor,
      colorText: Colors.white,
    );
  }
}
