import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/cart.dart';
import 'package:shopping/providers/product.dart';
import 'package:shopping/providers/products.dart';
import 'package:shopping/widgets/badge.dart';
import 'package:shopping/widgets/drawer.dart';
import 'package:shopping/widgets/product_item.dart';
import 'package:shopping/screens/cart_overview.dart';

enum Choice {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  static final String route = '/products';
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _favoritesOnly = false;
  bool _isLoading = true;

  @override
  void initState() {
    Provider.of<Products>(context, listen: false)
        .fetchProducts()
        .then((_) => setState(() => _isLoading = false));
    super.initState();
  }

  @override
  Widget build(BuildContext ctx) {
    // final Products products = Provider.of(ctx, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Products overview'),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (ctx) => [
              PopupMenuItem(
                child: Text('Favorites'),
                value: Choice.Favorites,
              ),
              PopupMenuItem(
                child: Text('All'),
                value: Choice.All,
              ),
            ],
            onSelected: (Choice value) {
              switch (value) {
                case Choice.Favorites:
                  // products.showFavoritesOnly();
                  setState(() {
                    _favoritesOnly = true;
                  });
                  break;
                case Choice.All:
                  setState(() {
                    _favoritesOnly = false;
                  });
                  break;
              }
            },
          ),
          Consumer<Cart>(
            builder: (ctx, cart, child) => Badge(
              value: cart.itemCount.toString(),
              child: child,
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(ctx).pushNamed(CartOverviewScreen.route);
              },
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ProductsGrid(_favoritesOnly),
    );
  }
}

class ProductsGrid extends StatelessWidget {
  final bool favoritesOnly;
  ProductsGrid(this.favoritesOnly);
  @override
  Widget build(BuildContext context) {
    List<Product> products;
    if (favoritesOnly) {
      products = Provider.of<Products>(context).showFavoritesOnly();
    } else {
      products = Provider.of<Products>(context).items;
    }
    return GridView.builder(
      itemBuilder: (BuildContext ctx, int index) {
        return ChangeNotifierProvider.value(
          value: products[index],
          child: ProductItem(),
        );
      },
      itemCount: products.length,
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
    );
  }
}
