import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';
import '../helpers/shared_preference.dart';
import '../utils/global.dart';

class GoogleButtonWidget extends StatelessWidget {
  const GoogleButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: Text(
            "-Or sign in with-",
            style:
                TextStyle(color: Global.textColor, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 20),
        FloatingActionButton.extended(
          onPressed: () async {
            await loginController.googleLogin();
            await IdStoring.setId("GoogleLogged");
            //loginController.googleLogin();
          },
          icon: Image.asset(
            "assets/images/google.png",
            height: 32,
            width: 32,
          ),
          label: const Text("Sign In With Google"),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ],
    );
  }
}
