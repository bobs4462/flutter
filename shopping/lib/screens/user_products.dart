import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/product.dart';
import 'package:shopping/providers/products.dart';
import 'package:shopping/screens/product_editor.dart';
import 'package:shopping/widgets/drawer.dart';
import 'package:shopping/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const String route = '/user/products';
  @override
  Widget build(BuildContext context) {
    final Products products = Provider.of<Products>(context, listen: false);
    final List<Product> items = products.items;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(ProductEditorScreen.route);
            },
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: FutureBuilder(
        future: products.fetchProducts(true),
        builder: (ctx, spapshot) =>
            spapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: () {
                      return products.fetchProducts(true);
                    },
                    child: Consumer<Products>(
                      builder: (ctx, prod, child) => Padding(
                        padding: EdgeInsets.all(8),
                        child: ListView.builder(
                          itemCount: products.itemCount,
                          itemBuilder: (ctx, i) => Column(
                            children: [
                              UserProductItem(items[i]),
                              Divider(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
