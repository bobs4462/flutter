import 'package:flutter/material.dart';
import 'package:gusto/widgets/screens/tabs.dart';
import 'package:gusto/widgets/screens/settings.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return Drawer(
      child: Column(children: [
        Container(
          height: 130,
          alignment: Alignment.centerLeft,
          width: double.infinity,
          padding: EdgeInsets.all(15),
          color: Theme.of(ctx).accentColor,
          child: Text(
            'El-Gusto',
            style: TextStyle(
              color: Theme.of(ctx).primaryColor,
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        SizedBox(height: 20),
        ListTile(
          leading: Icon(Icons.restaurant),
          title: Text(
            'Meals',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Chilanka',
              fontWeight: FontWeight.w700,
            ),
          ),
          onTap: () {
            Navigator.of(ctx).pushReplacementNamed(TabsScreenBottom.route);
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text(
            'Settings',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Chilanka',
              fontWeight: FontWeight.w700,
            ),
          ),
          onTap: () {
            Navigator.of(ctx).pushReplacementNamed(SettingsScreen.route);
          },
        ),
      ]),
    );
  }
}
