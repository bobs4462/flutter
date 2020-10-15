import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final Color color;
  final String title;
  CategoryItem({this.id, this.color, this.title});

  void select(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      '/meal-screen',
      arguments: {
        'categoryTitle': title,
        'categoryId': id,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => select(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.6), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
      ),
    );
  }
}
