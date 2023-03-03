import 'package:ecom/helpers/sql_helper.dart';
import 'package:ecom/views/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/global.dart';

class CartController extends GetxController {
  var productsList = [].obs;
  var products = {}.obs;
  var isAddedToCart = false.obs;
  var selectedProduct = {};
  var cartProducts = [].obs;
  var favList = [].obs;
  var isFav = false.obs;

  getProductDetail(id) async {
    products.value = (await SQLHelper.getItem(id)) as Map;
    return products;
  }

  addToCart(product) {
    if (!cartProducts.contains(selectedProduct)) {
      cartProducts.add(selectedProduct);
      isAddedToCart.value = true;
    } else {
      Get.snackbar("Opps", "Product Already In Cart",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Global.mainColor,
          colorText: Global.logoColor,
          margin: const EdgeInsets.all(5));
    }
  }

  removeFromCart(product) {
    if (cartProducts.contains(product)) {
      cartProducts.remove(product);
    }
  }

  addRemoveToFavorite() async {
    if (favList.contains(selectedProduct['id'])) {
      favList.remove(selectedProduct['id']);
      isFav.value = false;
    } else {
      favList.add(selectedProduct['id']);
      isFav.value = true;
    }
  }

  checkFavorite() {
    if (favList.contains(selectedProduct['id'])) {
      isFav.value = true;
    } else {
      isFav.value = false;
    }
  }

  checkCart() {
    if (cartProducts.contains(selectedProduct)) {
      isAddedToCart.value = true;
    } else {
      isAddedToCart.value = false;
    }
  }

  Widget cartIcon(productController, index) {
    return Obx(
      () => Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  Get.to(() => CartProductsScreen(
                        index: index,
                      ));
                },
                icon: const Icon(Icons.shopping_cart)),
          ),
          if (productController.cartProducts.isNotEmpty)
            Positioned(
              top: 5,
              right: 9,
              child: Container(
                height: 20,
                width: 20,
                decoration: const BoxDecoration(
                    color: Colors.black87, shape: BoxShape.circle),
                child: Center(
                  child: Text(
                    '${productController.cartProducts.length}',
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
