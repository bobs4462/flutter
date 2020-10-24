import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/auth.dart';
import 'package:shopping/providers/cart.dart';
import 'package:shopping/providers/orders.dart';
import 'package:shopping/providers/products.dart';
import 'package:shopping/screens/cart_overview.dart';
import 'package:shopping/screens/order_overview.dart';
import 'package:shopping/screens/product_details.dart';
import 'package:shopping/screens/product_editor.dart';
import 'package:shopping/screens/products_overview.dart';
import 'package:shopping/screens/splash_screen.dart';
import 'package:shopping/screens/user_products.dart';
import 'package:shopping/screens/auth_screen.dart';

void main() {
  runApp(ShoppingApp());
}

class ShoppingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => Auth()),
          ChangeNotifierProxyProvider<Auth, Products>(
            create: (ctx) => Products(),
            update: (ctx, auth, previousState) => previousState
              ..update(auth.token, auth.userId, previousState.items),
          ),
          ChangeNotifierProvider(create: (ctx) => Cart()),
          ChangeNotifierProxyProvider<Auth, Orders>(
            create: (ctx) => Orders(),
            update: (ctx, auth, orders) =>
                orders..update(auth.token, auth.userId, orders.orders),
          ),
        ],
        child: Consumer<Auth>(builder: (
          ctx,
          auth,
          child,
        ) {
          return MaterialApp(
            title: 'Let\'s shop',
            theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              fontFamily: 'PT Sans',
            ),
            home: auth.isAuthenticated
                ? ProductsOverviewScreen()
                : FutureBuilder(
                    future: auth.tryLogin(),
                    builder: (ctx, snapshot) {
                      return snapshot.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen();
                    },
                  ),
            routes: {
              ProductDetailsScreen.route: (ctx) => ProductDetailsScreen(),
              CartOverviewScreen.route: (ctx) => CartOverviewScreen(),
              ProductsOverviewScreen.route: (ctx) => ProductsOverviewScreen(),
              OrdersOverviewScreen.route: (ctx) => OrdersOverviewScreen(),
              UserProductsScreen.route: (ctx) => UserProductsScreen(),
              ProductEditorScreen.route: (ctx) => ProductEditorScreen(),
              AuthScreen.route: (ctx) => AuthScreen(),
            },
          );
        }));
  }
}
