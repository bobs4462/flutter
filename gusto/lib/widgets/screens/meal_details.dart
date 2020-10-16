import 'package:flutter/material.dart';
import 'package:gusto/models/meal.dart';

class MealDetailsScreen extends StatelessWidget {
  static final route = '/meal-details-screen';
  Widget buildSectionTitle({String title, BuildContext ctx}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 11),
      child: Text(title, style: Theme.of(ctx).textTheme.headline6),
    );
  }

  Widget buildContainer({Widget wdgt, BuildContext ctx}) {
    return Container(
      height: MediaQuery.of(ctx).size.height * 0.3,
      width: MediaQuery.of(ctx).size.width * 0.6,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: wdgt,
    );
  }

  @override
  Widget build(BuildContext ctx) {
    final Meal meal = (ModalRoute.of(ctx).settings.arguments as Map)['meal'];
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: 400,
                  width: double.infinity,
                  child: Image.network(
                    meal.imageUrl,
                    fit: BoxFit.cover,
                  )),
              buildSectionTitle(title: 'Ingredients', ctx: ctx),
              buildContainer(
                ctx: ctx,
                wdgt: ListView(
                  children: meal.ingredients
                      .map((m) => Card(
                            color: Theme.of(ctx).accentColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                m,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
              buildSectionTitle(title: 'Steps', ctx: ctx),
              buildContainer(
                ctx: ctx,
                wdgt: ListView.builder(
                  itemBuilder: (ctx, index) => Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('# ${index + 1}'),
                        ),
                        title: Text(
                          meal.steps[index],
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Divider(color: Colors.grey),
                    ],
                  ),
                  itemCount: meal.steps.length,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(ctx).pop(meal.id);
        },
        child: Icon(Icons.delete),
      ),
    );
  }
}
