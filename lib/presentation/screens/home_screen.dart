import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:grocey/data/modules/dumydata.dart';
import 'package:grocey/data/modules/grocery.dart';
import 'package:grocey/data/modules/grocery_item.dart';
import 'package:grocey/presentation/widgets/drop_down_button_items.dart';
import 'package:grocey/presentation/widgets/grocery_items_group.dart';
import 'package:grocey/presentation/widgets/my_button_form.dart';
import 'package:grocey/presentation/widgets/my_text_form_field.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController groceryItemNameController =
      TextEditingController();
  final TextEditingController groceryQuanitityController =
      TextEditingController();
  Grocery? selectedCategory;
  List<GroceryItem> loadedgroceryList = [];
  bool isloading = true;
  final formKey = GlobalKey<FormState>();
  String? error;
  void onChange(newGroceryItem) {
    setState(() {
      selectedCategory = newGroceryItem;
    });
  }

  void onsave() {
    if (formKey.currentState!.validate()) {
      if (selectedCategory != null &&
          groceryItemNameController.text.isNotEmpty &&
          groceryQuanitityController.text.isNotEmpty) {
        addITemToFirebase();
      }
    }
  }

  void addITemToFirebase() {
    final url = Uri.https(
        'grocery-fa6ae-default-rtdb.firebaseio.com', 'grocery-list.json');
    http
        .post(url,
            headers: {"Content-Type": "application/json"},
            body: json.encode({
              'groceryItemName': groceryItemNameController.text,
              'groceryItemQuantity': groceryQuanitityController.text,
              'groceryItemCategory': selectedCategory!.groceryItemCategory
            }))
        .then((postResponse) {
      if (postResponse.statusCode == 200) {
        final Map<String, dynamic> newAddeditem =
            json.decode(postResponse.body);
        setState(() {
          loadedgroceryList.add(GroceryItem(
              id: newAddeditem['name'],
              name: groceryItemNameController.text,
              quiantity: int.parse(groceryQuanitityController.text),
              category: selectedCategory!));
        });
        formKey.currentState!.reset();
        groceryItemNameController.clear();
        groceryQuanitityController.clear();
        showToast(
          'Item add sucessfully',
          context: context,
          animation: StyledToastAnimation.scale,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.center,
          animDuration: const Duration(seconds: 1),
          duration: const Duration(seconds: 4),
          curve: Curves.elasticOut,
          reverseCurve: Curves.linear,
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    groceryItemNameController.dispose();
    groceryQuanitityController.dispose();
  }

  void getGroceryDate() async {
    final url = Uri.https(
        'grocery-fa6ae-default-rtdb.firebaseio.com', 'grocery-list.json');
    final getRespone = await http.get(url);
    if (getRespone.statusCode == 200) {
      if (getRespone.contentLength == 4) {
        showToast(
          'something went wrong',
          context: context,
          animation: StyledToastAnimation.scale,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.center,
          animDuration: const Duration(seconds: 1),
          duration: const Duration(seconds: 4),
          curve: Curves.elasticOut,
          reverseCurve: Curves.linear,
        );
        setState(() {
          isloading = false;
        });
        return;
      }
      final Map<String, dynamic> loadedDatad = json.decode(getRespone.body);

      final List<GroceryItem> loadedgrocery = [];
      for (var item in loadedDatad.entries) {
        final loadedCategory = groceries.entries
            .firstWhere(
              (element) =>
                  element.value.groceryItemCategory ==
                  item.value["groceryItemCategory"],
            )
            .value;
        loadedgrocery.add(GroceryItem(
            id: item.key,
            name: item.value["groceryItemName"],
            quiantity: int.parse(item.value["groceryItemQuantity"]),
            category: loadedCategory));
      }

      setState(() {
        loadedgroceryList = loadedgrocery;
        isloading = false;
      });
    } else {
      showToast(
        "Failed to fetch data,please try again",
        context: context,
        animation: StyledToastAnimation.scale,
        reverseAnimation: StyledToastAnimation.fade,
        position: StyledToastPosition.center,
        animDuration: const Duration(seconds: 1),
        duration: const Duration(seconds: 4),
        curve: Curves.elasticOut,
        reverseCurve: Curves.linear,
      );
      setState(() {
        error = "Failed to fetch data,please try again";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getGroceryDate();
  }

  void newGroceryItem(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
        isDismissible: false,
        useSafeArea: true,
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey[300],
            ),
            child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const Text(
                      "Add New Item",
                      style: TextStyle(fontSize: 26),
                      textAlign: TextAlign.center,
                    ),
                    MyTextFormField(
                      textformfieldcontroller: groceryItemNameController,
                      hintText: "Enter Grocery Item",
                      validator: (value) {
                        if (value!.isEmpty ||
                            value.trim().length <= 1 ||
                            value.trim().length > 50) {
                          return "Must between 1 to 50 characters";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: MyTextFormField(
                              textformfieldcontroller:
                                  groceryQuanitityController,
                              hintText: "Quanitity",
                              validator: (value) {
                                if (value!.isEmpty || value.trim().length > 6) {
                                  return "Requierd Field";
                                } else {
                                  return null;
                                }
                              }),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Flexible(
                          child: DropDownButtonItems(
                            onChanged: (value) {
                              onChange(value);
                            },
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyButtonForm(
                          buttonname: "Add",
                          onTap: onsave,
                        ),
                        MyButtonForm(
                          buttonname: "Cancel",
                          onTap: () {
                            if (selectedCategory != null ||
                                groceryItemNameController.text.isNotEmpty ||
                                groceryQuanitityController.text.isNotEmpty) {
                              showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                        content: const Text("Are You Sure!"),
                                        actions: [
                                          MyButtonForm(
                                            buttonname: "Yes",
                                            onTap: () {
                                              Navigator.of(context).popUntil(
                                                  (route) => route.isFirst);
                                              groceryItemNameController.clear();
                                              groceryQuanitityController
                                                  .clear();
                                            },
                                          ),
                                          MyButtonForm(
                                            buttonname: "No",
                                            onTap: () => Navigator.pop(ctx),
                                          ),
                                        ],
                                      ));
                            } else {
                              Navigator.pop(context);
                            }
                          },
                        )
                      ],
                    )
                  ],
                )),
          );
        });
  }

  void deleteItem(
    GroceryItem item,
  ) async {
    final url = Uri.https('grocery-fa6ae-default-rtdb.firebaseio.com',
        'grocery-list/${item.id}.json');
    final deleteResponse = await http.delete(url);
    if (deleteResponse.statusCode == 200) {
      showToast(
        '${item.name} deleted sucessfully',
        context: context,
        animation: StyledToastAnimation.scale,
        reverseAnimation: StyledToastAnimation.fade,
        position: StyledToastPosition.center,
        animDuration: const Duration(seconds: 1),
        duration: const Duration(seconds: 4),
        curve: Curves.elasticOut,
        reverseCurve: Curves.linear,
      );
      setState(() {
        loadedgroceryList.remove(item);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey[300],
          onPressed: () {
            newGroceryItem(context);
          },
          child: const Icon(
            Icons.add_task,
            size: 32,
          ),
        ),
        appBar: AppBar(
          title: const Text(
            "Grocery List",
            style: TextStyle(
                fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  final url = Uri.https(
                      'grocery-fa6ae-default-rtdb.firebaseio.com',
                      'grocery-list.json');
                  final restResponse = await http.delete(url);
                  if (restResponse.statusCode == 200) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("sucessfully")));
                    setState(() {
                      loadedgroceryList.clear();
                    });
                  }
                },
                icon: const Icon(
                  Icons.delete_forever,
                  size: 32,
                  color: Colors.white,
                ))
          ],
        ),
        body: GroceryItemsGroup(
          groceryList: loadedgroceryList,
          isloading: isloading,
          erorr: error,
          deleteItem: deleteItem,
        ));
  }
}
