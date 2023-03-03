import 'package:ecom/helpers/shared_preference.dart';
import 'package:ecom/views/admin_home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/location_controller.dart';
import '../controllers/login_controller.dart';
import '../utils/global.dart';
import '../widgets/button_widgets.dart';
import '../widgets/google_button_widget.dart';
import '../widgets/text_field_widget.dart';

class LoginScreen extends StatelessWidget {
  final loginController = Get.put(LoginController());
  final locationController = Get.put(LocationController());
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final String email = "admin@gmail.com";
  final String password = "admin";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: SafeArea(
              child: Center(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "E-COM",
                  style: TextStyle(
                    color: Global.mainColor,
                    fontSize: 35,
                    fontWeight: Global.bold,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                      color: Global.textColor,
                      fontSize: 16,
                      fontWeight: Global.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFieldWidget(
                    controller: emailController,
                    isObscure: false,
                    text: 'Email',
                    textInputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 10),
                  TextFieldWidget(
                    controller: passwordController,
                    isObscure: true,
                    text: 'Password',
                    textInputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 30),
                  ButtonWidget(
                    text: 'Sign In',
                    onTap: () {
                      if (emailController.text.isEmpty) {
                        loginController.errorSnackBar(
                            'Error', 'Enter the Email');
                      } else if (passwordController.text.isEmpty) {
                        loginController.errorSnackBar(
                            'Error', 'Enter the password');
                      } else if (email == emailController.text &&
                          password == passwordController.text) {
                        loginController.successSnackBar(
                            'Success', 'Successfully Logged in');
                        IdStoring.setId("Admin");
                        Get.offAll(() => AdminHomePage());
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  const GoogleButtonWidget(),
                  const SizedBox(height: 20),
                  // ignore: unrelated_type_equality_checks
                  Card(
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: Obx(
                        () => Text(
                            "${locationController.latitude} & ${locationController.longitude}"),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ))),
    );
  }
}
