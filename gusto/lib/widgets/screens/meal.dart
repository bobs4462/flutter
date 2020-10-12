import 'package:flutter/material.dart';

class MealScreen extends StatelessWidget {
  final String mealName;
  final int mealId;
  MealScreen({@required this.mealName, @required this.mealId});
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mealName),
      ),
      body: Center(
        child: Text('hello'),
      ),
    );
  }
}
