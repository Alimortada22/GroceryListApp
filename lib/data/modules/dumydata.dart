import 'package:grocey/data/modules/grocery.dart';
import 'package:grocey/data/modules/grocery_item.dart';

final groceryList = [
  GroceryItem(
      id: "a",
      name: "Apple",
      category: groceries[GrocerySections.fruit]!,
      quiantity: 15),
  GroceryItem(
      id: "b",
      quiantity: 5,
      name: "Rice",
      category: groceries[GrocerySections.carbs]!),
  GroceryItem(
      id: "b",
      quiantity: 5,
      name: "Milk",
      category: groceries[GrocerySections.diary]!),
  GroceryItem(
      id: "b",
      quiantity: 5,
      name: "Chicken",
      category: groceries[GrocerySections.meat]!),
  GroceryItem(
      id: "b",
      quiantity: 5,
      name: "Lollipop",
      category: groceries[GrocerySections.sweets]!),
];
const Map<GrocerySections, Grocery> groceries = {
  GrocerySections.fruit: Grocery(
      groceryItemCategory: "fruit",
      grocerySectionIcon: "assests/images/fruits.png"),
  GrocerySections.carbs: Grocery(
      groceryItemCategory: "carbs",
      grocerySectionIcon: "assests/images/carb.png"),
  GrocerySections.diary: Grocery(
      groceryItemCategory: "diary",
      grocerySectionIcon: "assests/images/dairy.png"),
  GrocerySections.meat: Grocery(
      groceryItemCategory: "meat",
      grocerySectionIcon: "assests/images/barbecue.png"),
  GrocerySections.spices: Grocery(
      groceryItemCategory: "spices",
      grocerySectionIcon: "assests/images/chilli.png"),
  GrocerySections.vegatables: Grocery(
      groceryItemCategory: "vegatables",
      grocerySectionIcon: "assests/images/vegetable.png"),
  GrocerySections.sweets: Grocery(
      groceryItemCategory: "sweets",
      grocerySectionIcon: "assests/images/sweets.png"),
  GrocerySections.hygiene: Grocery(
      groceryItemCategory: "hygiene",
      grocerySectionIcon: "assests/images/safe.png"),
  GrocerySections.other: Grocery(
      groceryItemCategory: "other",
      grocerySectionIcon: "assests/images/24-hours.png")
};
