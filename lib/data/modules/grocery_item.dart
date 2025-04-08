import 'package:grocey/data/modules/grocery.dart';

enum GrocerySections {
  vegatables,
  fruit,
  meat,
  diary,
  carbs,
  sweets,
  spices,
  convenience,
  hygiene,
  other
}

class GroceryItem {
  final String id;
  final String name;
  final int quiantity;
  final Grocery category;
  const GroceryItem(
      {required this.id,
      required this.name,
      required this.quiantity,
      required this.category});
}
