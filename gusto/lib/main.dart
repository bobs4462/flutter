import 'package:flutter/material.dart';
import 'package:gusto/widgets/screens/categories_screen.dart';
import 'package:gusto/widgets/screens/settings.dart';
import 'package:gusto/widgets/screens/tabs.dart';
import 'package:gusto/widgets/screens/meals_screen.dart';
import 'package:gusto/widgets/screens/meal_details.dart';
import 'package:gusto/models/meal.dart';
import 'package:gusto/data/dummy.dart';

void main() {
  runApp(GustoApp());
}

class GustoApp extends StatefulWidget {
  static const String title = 'El-Gusto';

  @override
  _GustoAppState createState() => _GustoAppState();
}

class _GustoAppState extends State<GustoApp> {
  Map<String, bool> _filters = {
    'Gluten': false,
    'Lactose': false,
    'Vegan': false,
    'Vegetarian': false,
  };

  List<Meal> meals = DUMMY_MEALS;
  void _setFilters(Map<String, bool> filters) {
    setState(() {
      _filters = filters;
      meals = DUMMY_MEALS.where((m) {
        if (_filters['Gluten'] && !m.isGlutenFree) {
          return false;
        }
        if (_filters['Lactose'] && !m.isLactoseFree) {
          return false;
        }
        if (_filters['Vegan'] && !m.isVegan) {
          return false;
        }
        if (_filters['Vegetarian'] && !m.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext ctx) {
    return MaterialApp(
      title: GustoApp.title,
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
      home: TabsScreenBottom(),
      routes: {
        MealsScreen.route: (ctx) => MealsScreen(meals),
        SettingsScreen.route: (ctx) =>
            SettingsScreen(setFilters: _setFilters, filters: _filters),
        CategoriesScreen.route: (ctx) => CategoriesScreen(),
        MealDetailsScreen.route: (ctx) => MealDetailsScreen(),
      },
    );
  }
}
