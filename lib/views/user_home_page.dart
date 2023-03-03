import 'package:ecom/utils/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../controllers/login_controller.dart';
import 'detail_page.dart';

class HomeScreen extends StatelessWidget {
  final loginController = Get.put(LoginController());
  final homeController = Get.put(HomeController());
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Global.mainColor,
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              loginController.googleLogout(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: GetBuilder<HomeController>(builder: (homeController) {
          homeController.refreshJournals();
          return homeController.products != null
              ? GridView.builder(
                  shrinkWrap: false,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1, mainAxisExtent: 200),
                  itemCount: homeController.products.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          print(homeController.products[index]);
                          Get.to(() => DetailScreen(
                                index: homeController.products[index],
                              ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Global.mainColor,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 25),
                              CircleAvatar(
                                backgroundColor: Global.logoColor,
                                backgroundImage: const AssetImage(
                                    'assets/images/google.png'),
                                radius: 50,
                              ),
                              const SizedBox(width: 40),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Product Name : ${homeController.products[index]['productName']}',
                                    style: TextStyle(color: Global.logoColor),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                      'Strap Color : ${homeController.products[index]['strapColor']}',
                                      style:
                                          TextStyle(color: Global.logoColor)),
                                  const SizedBox(height: 10),
                                  Text(
                                      'HighLight : ${homeController.products[index]['highLight']}',
                                      style:
                                          TextStyle(color: Global.logoColor)),
                                  const SizedBox(height: 10),
                                  Text(
                                      'Price : ${homeController.products[index]['productPrice']}',
                                      style:
                                          TextStyle(color: Global.logoColor)),
                                  const SizedBox(height: 10),
                                  homeController.products[index]['status'] ==
                                          'available'
                                      ? Text(
                                          'Stock : ${homeController.products[index]['status']}',
                                          style: TextStyle(
                                              color: Global.logoColor))
                                      : Text('Stock : Out of Stock',
                                          style: TextStyle(
                                              color: Global.logoColor)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              : const CupertinoActivityIndicator();
        }),
      ),
    );
  }
}
