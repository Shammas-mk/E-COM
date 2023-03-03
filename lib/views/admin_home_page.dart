import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../controllers/login_controller.dart';
import '../helpers/sql_helper.dart';
import '../utils/global.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final homeController = Get.put(HomeController());
  final loginController = Get.put(LoginController());

  // All journals
  List<Map<String, dynamic>> _journals = [];

  bool _isLoading = true;
  // This function is used to fetch all data from the database
  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
      _isLoading = false;
    });

    homeController.products = data as RxList<Map<String, dynamic>>;
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals(); // Loading the diary when the app starts
  }

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _strapColorController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  void _showForm(int? id) async {
    if (id != null) {
      final existingJournal =
          _journals.firstWhere((element) => element['id'] == id);
      _productNameController.text = existingJournal['productName'];
      _strapColorController.text = existingJournal['strapColor'];
      homeController.dropdownvalue.value = existingJournal['highLight'];
      _priceController.text = existingJournal['productPrice'].toString();
      homeController.isAvail.value = existingJournal['status'];
    }

    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                top: 45,
                left: 15,
                right: 15,
                bottom: MediaQuery.of(context).viewInsets.bottom + 10,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    autofocus: true,
                    controller: _productNameController,
                    decoration: const InputDecoration(hintText: 'Product Name'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    autofocus: true,
                    controller: _strapColorController,
                    decoration: const InputDecoration(hintText: 'Strap Color'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownButton(
                    isExpanded: true,
                    value: homeController.dropdownvalue.value,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: homeController.highLights.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      homeController.dropdownvalue.value = newValue.toString();
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    autofocus: true,
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: 'Price'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownButton(
                    isExpanded: true,
                    value: homeController.isAvail.value,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: homeController.isAvailable.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      homeController.isAvail.value = newValue.toString();
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Global.mainColor,
                      ),
                      onPressed: () async {
                        if (id == null) {
                          await _addItem();
                        }

                        if (id != null) {
                          await _updateItem(id);
                        }

                        // Clear the text fields
                        _productNameController.text = '';
                        _strapColorController.text = '';
                        homeController.dropdownvalue.value = 'Latest';
                        _priceController.text = '';
                        homeController.isAvail.value = 'available';

                        // Close the bottom sheet
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                      },
                      child: Text(id == null ? 'Create New' : 'Update'),
                    ),
                  )
                ],
              ),
            ));
  }

// Insert a new journal to the database
  Future<void> _addItem() async {
    await SQLHelper.createItem(
        _productNameController.text,
        _strapColorController.text,
        homeController.dropdownvalue.value,
        int.parse(_priceController.text),
        homeController.isAvail.value);

    _refreshJournals();
  }

  // Update an existing journal
  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(
        id,
        _productNameController.text,
        _strapColorController.text,
        homeController.dropdownvalue.value,
        int.parse(_priceController.text),
        homeController.isAvail.value);
    _refreshJournals();
  }

  // Delete an item
  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a journal!'),
    ));
    _refreshJournals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Global.mainColor,
        title: const Text('Admin Home Screen'),
        actions: [
          IconButton(
              onPressed: () {
                loginController.googleLogout(context);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _journals.length,
              itemBuilder: (context, index) => Card(
                color: Global.mainColor,
                margin: const EdgeInsets.all(15),
                child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text("Id  : ${_journals[index]['id']}",
                        //     style: TextStyle(color: Global.logoColor)),
                        Text(
                          "Product Name : ${_journals[index]['productName']}",
                          style: TextStyle(color: Global.logoColor),
                        ),
                        Text("Strap Color : ${_journals[index]['strapColor']}",
                            style: TextStyle(color: Global.logoColor)),
                        Text(
                          "HighLight :${_journals[index]['highLight']}",
                          style: TextStyle(color: Global.logoColor),
                        ),
                        Text(
                          "Price  : ${_journals[index]['productPrice']}",
                          style: TextStyle(color: Global.logoColor),
                        ),
                        Text(
                          "Status  : ${_journals[index]['status']}",
                          style: TextStyle(color: Global.logoColor),
                        ),
                      ],
                    ),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            onPressed: () => _showForm(_journals[index]['id']),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                            onPressed: () =>
                                _deleteItem(_journals[index]['id']),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Global.mainColor,
        child: const Icon(Icons.add),
        onPressed: () => _showForm(null),
      ),
    );
  }
}
