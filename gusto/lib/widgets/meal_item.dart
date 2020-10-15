import 'package:flutter/material.dart';
import 'package:gusto/models/meal.dart';
import 'package:gusto/widgets/screens/meal_details.dart';

class MealItem extends StatelessWidget {
  final Meal meal;
  MealItem(this.meal);
  String get complexity {
    switch (this.meal.complexity) {
      case Complexity.Simple:
        return 'simple';
      case Complexity.Challenging:
        return 'challenging';
      case Complexity.Hard:
        return 'hard';
      default:
        return 'impossible';
    }
  }

  String get affordability {
    switch (this.meal.affordability) {
      case Affordability.Affordable:
        return 'affordable';
      case Affordability.Pricey:
        return 'pricey';
      case Affordability.Luxurious:
        return 'luxurious';
      default:
        return 'impossible';
    }
  }

  void select(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      MealDetailsScreen.route,
      arguments: {
        'meal': meal,
      },
    );
  }

  @override
  Widget build(BuildContext ctx) {
    return InkWell(
      onTap: () => select(ctx),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    meal.imageUrl,
                    height: 350,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 15,
                  right: 7,
                  child: Container(
                    width: 350,
                    color: Colors.black26,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      meal.title,
                      style: TextStyle(
                        fontSize: 29,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(Icons.schedule),
                      SizedBox(width: 10),
                      Text(
                        '${meal.duration} min',
                        style: TextStyle(fontSize: 21),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.work),
                      SizedBox(width: 10),
                      Text(
                        '$complexity \u{1f609}',
                        style: TextStyle(fontSize: 21),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.attach_money),
                      SizedBox(width: 10),
                      Text(
                        '$affordability',
                        style: TextStyle(fontSize: 21),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
