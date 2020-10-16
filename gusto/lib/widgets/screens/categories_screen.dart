import 'package:flutter/material.dart';
import 'package:gusto/data/dummy.dart';
import 'package:gusto/widgets/category_item.dart';
// import 'package:gusto/models/category.dart';

class CategoriesScreen extends StatelessWidget {
  static final String route = '/categories';
  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(19),
      children: DUMMY_CATEGORIES.map((cat) {
        return CategoryItem(id: cat.id, color: cat.color, title: cat.title);
      }).toList(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 3 / 2,
      ),
    );
  }
}
