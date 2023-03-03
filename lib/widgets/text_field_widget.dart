import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.text,
    required this.textInputType,
    required this.isObscure,
  });
  final TextEditingController controller;
  final String text;
  final TextInputType textInputType;
  final bool isObscure;

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    return Container(
      height: 55,
      padding: const EdgeInsets.only(top: 2, left: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 7,
          ),
        ],
      ),
      child: Form(
        key: formkey,
        child: TextFormField(
          controller: controller,
          keyboardType: textInputType,
          obscureText: isObscure,
          decoration: InputDecoration(
            hintText: text,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(0),
            hintStyle: const TextStyle(height: 1),
          ),
        ),
      ),
    );
  }
}
