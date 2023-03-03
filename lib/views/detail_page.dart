import 'package:ecom/helpers/sql_helper.dart';
import 'package:ecom/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({super.key, required dynamic index}) : _index = index;
  var _index;

  get index => _index;

  set index(value) {
    _index = value;
  }

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Page'),
        backgroundColor: Global.mainColor,
        actions: [
          cartController.cartIcon(cartController, index['id']),
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.1))
                  ]),
                  height: 400,
                  alignment: Alignment.center,
                  child: Image.asset('assets/images/google.png'),
                ),
                const SizedBox(height: 20),
                Text(
                  'Product : ${index['productName']}',
                  style: TextStyle(fontSize: 30, color: Global.textColor),
                ),
                const SizedBox(height: 20),
                Text(
                  'Strap Color : ${index['strapColor']}',
                  style: TextStyle(fontSize: 30, color: Global.textColor),
                ),
                const SizedBox(height: 20),
                Text(
                  'High Lights : ${index['highLight']}',
                  style: TextStyle(fontSize: 30, color: Global.textColor),
                ),
                const SizedBox(height: 20),
                Text(
                  'Price : ${index['productPrice']}',
                  style: TextStyle(fontSize: 30, color: Global.textColor),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () async {
            if (index['status'] == 'available') {
              cartController.addToCart(index);
            } else {
              Get.snackbar('Out of Stock', 'Product is out of Stock',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Global.mainColor,
                  colorText: Global.logoColor,
                  margin: const EdgeInsets.all(5));
            }
          },
          child: const Text('Add to Cart')),
    );
  }
}
