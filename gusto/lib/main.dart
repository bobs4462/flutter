import 'package:flutter/material.dart';
import 'package:gusto/widgets/screens/categories_screen.dart';
import 'package:gusto/widgets/screens/meals_screen.dart';
import 'package:gusto/widgets/screens/meal_details.dart';

void main() {
  runApp(GustoApp());
}

class GustoApp extends StatelessWidget {
  static const String title = 'El-Gusto';
  @override
  Widget build(BuildContext ctx) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        accentColor: Colors.pink,
        canvasColor: Color.fromRGBO(215, 215, 215, 0.6),
        fontFamily: 'Chilanka',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(50, 15, 80, 0.5),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(90, 45, 180, 0.7),
              ),
              headline6: TextStyle(
                fontSize: 27,
                fontFamily: 'Piazzolla',
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
      ),
      home: CategoriesScreen(),
      routes: {
        MealsScreen.route: (ctx) => MealsScreen(),
        MealDetailsScreen.route: (ctx) => MealDetailsScreen(),
      },
    );
  }
}
