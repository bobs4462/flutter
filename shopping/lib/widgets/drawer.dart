import 'package:flutter/material.dart';
import 'package:shopping/screens/products_overview.dart';
import 'package:shopping/screens/order_overview.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Shopping!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(ProductsOverviewScreen.route),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(OrdersOverviewScreen.route),
          ),
        ],
      ),
    );
  }
}
