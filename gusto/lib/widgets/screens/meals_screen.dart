import 'package:flutter/material.dart';
import 'package:gusto/data/dummy.dart';
import 'package:gusto/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  static const route = '/meal-screen';
  // final String mealName;
  // final int mealId;
  @override
  Widget build(BuildContext ctx) {
    final args = ModalRoute.of(ctx).settings.arguments as Map<String, Object>;
    final id = args['categoryId'];
    final title = args['categoryTitle'];
    final meals =
        DUMMY_MEALS.where((meal) => meal.categories.contains(id)).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: ListView.builder(
            itemBuilder: (ctx, index) {
              return MealItem(meals[index]);
            },
            itemCount: meals.length),
      ),
    );
  }
}
