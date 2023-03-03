import 'package:ecom/helpers/sql_helper.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // All journals
  List<Map<String, dynamic>> products = [];

  RxBool isLoading = true.obs;
  // This function is used to fetch all data from the database

  RxString dropdownvalue = 'Latest'.obs;
  RxString isAvail = 'available'.obs;

  // List of items in our dropdown menu
  var highLights = [
    'Latest',
    'Trending',
    'New Arrive',
  ];

  var isAvailable = [
    'available',
    'notAvailable',
  ];

  refreshJournals() async {
    final data = await SQLHelper.getItems();
    products = data;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    refreshJournals();
  }
}
