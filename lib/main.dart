import 'package:ecom/views/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'helpers/shared_preference.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IdStoring.init();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'E-COM',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
