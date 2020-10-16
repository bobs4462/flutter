import 'package:flutter/material.dart';
import 'package:gusto/models/meal.dart';
import 'package:gusto/widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favorites;
  FavoritesScreen(this.favorites);
  @override
  Widget build(BuildContext ctx) {
    if (favorites.isNotEmpty) {
      return ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              meal: favorites[index],
            );
          },
          itemCount: favorites.length);
    } else {
      return Center(
        child: Text('No favorites yet, add some!'),
      );
    }
  }
}
