import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:grocey/data/modules/grocery_item.dart';

class GroceryItemsGroup extends StatelessWidget {
  const GroceryItemsGroup(
      {super.key, required this.groceryList, required this.isloading,required this.erorr,required this.deleteItem});
  final List<GroceryItem> groceryList;
  final bool isloading;
  final String? erorr;
  final void Function(GroceryItem item)? deleteItem;
  @override
  Widget build(BuildContext context) {
      Widget contenet=const Center(child:  Text("No items added yet",style: TextStyle(fontSize: 32,color: Colors.white,fontWeight: FontWeight.bold),));

    if (groceryList.isNotEmpty) {
      contenet=ListView.builder(
          itemCount: groceryList.length,
          itemBuilder: (context, index) {
            return Slidable(
              startActionPane: ActionPane(motion: const ScrollMotion(), children:   [
      // A SlidableAction can have an icon and/or a label.
      SlidableAction(
        onPressed:  (context) {
          deleteItem!(groceryList[index]);
        },
        backgroundColor: const Color(0xFFFE4A49),
        foregroundColor: Colors.white,
        icon: Icons.delete,
        label: 'Delete',
      ),]),
              child: Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: Image.asset(
                    groceryList[index].category.grocerySectionIcon,
                    cacheWidth: 82,
                    cacheHeight: 66,
                  ),
                  title: Text(
                    groceryList[index].name,
                    style: const TextStyle(fontSize: 26),
                  ),
                  trailing: Text(groceryList[index].quiantity.toString(),
                      style: const TextStyle(fontSize: 26)),
                ),
              ),
            );
          });
    }
    if (isloading==true) {
      contenet=const Center(child:  CircularProgressIndicator());
    }
    if (erorr !=null) {
      contenet=Center(child: Text(erorr!));
    }


    
      return contenet;

  }
}
