import 'package:ecom/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartProductsScreen extends StatelessWidget {
  CartProductsScreen({super.key, required this.index});
  var index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<CartController>(builder: (controller) {
      controller.getProductDetail(index);
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$index'),
          Text('${controller.products['product']}'),
        ],
      );
    }));
  }
}
