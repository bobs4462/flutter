import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/auth.dart';
import 'package:shopping/screens/products_overview.dart';
import 'package:shopping/screens/order_overview.dart';
import 'package:shopping/screens/user_products.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage products'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(UserProductsScreen.route),
          ),
          Divider(),
          ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Provider.of<Auth>(context, listen: false).logout();
                Navigator.of(context).pushReplacementNamed('/');
              }),
        ],
      ),
    );
  }
}
