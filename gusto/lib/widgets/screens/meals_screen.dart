import 'package:flutter/material.dart';
import 'package:gusto/models/meal.dart';
import 'package:gusto/widgets/meal_item.dart';

class MealsScreen extends StatefulWidget {
  static const route = '/meal-screen';
  final List<Meal> meals;
  MealsScreen(this.meals);
  @override
  _MealsScreenState createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  String title;
  List<Meal> meals;
  @override
  // void initState() {
  //   final args =
  //       ModalRoute.of(context).settings.arguments as Map<String, Object>;
  //   final id = args['categoryId'];
  //   title = args['categoryTitle'];
  //   meals = DUMMY_MEALS.where((meal) => meal.categories.contains(id)).toList();
  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    final id = args['categoryId'];
    title = args['categoryTitle'];
    meals = widget.meals.where((meal) => meal.categories.contains(id)).toList();
  }

  void removeItem(mealId) {
    setState(() {
      meals.removeWhere((m) => m.id == mealId);
    });
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: ListView.builder(
            itemBuilder: (ctx, index) {
              return MealItem(
                meal: meals[index],
              );
            },
            itemCount: meals.length),
      ),
    );
  }
}
