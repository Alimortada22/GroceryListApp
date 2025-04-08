import 'package:flutter/material.dart';
import 'package:grocey/data/modules/dumydata.dart';
import 'package:grocey/data/modules/grocery.dart';

class DropDownButtonItems extends StatelessWidget {
  const DropDownButtonItems({super.key,required this.onChanged});
  final void Function(Grocery?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return  DropdownButtonFormField(
      
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12)
        )
      ),
                        hint: const Text("Select Grocery Section"),
                        items: [
                        for(final grocery in groceries.entries)
                         DropdownMenuItem(
                          value: grocery.value,
                          child: Row(
                          children: [
                            Image.asset(grocery.value.grocerySectionIcon,width: 30,height: 30,),
                            const SizedBox(width: 10,),
                            Text(grocery.value.groceryItemCategory)
                          ],
                        ))
                      ], onChanged: (value) {
                        if (value !=null) {
                           onChanged!(value);
                        }
                      },);
  }
}