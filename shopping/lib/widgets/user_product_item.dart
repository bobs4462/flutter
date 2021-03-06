import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/product.dart';
import 'package:shopping/providers/products.dart';
import 'package:shopping/screens/product_editor.dart';

class UserProductItem extends StatelessWidget {
  final Product product;
  UserProductItem(this.product);
  @override
  Widget build(BuildContext context) {
    final ScaffoldState scaffold = Scaffold.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.title),
      trailing: Container(
        width: 150,
        child: Row(children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.of(context).pushNamed(
              ProductEditorScreen.route,
              arguments: product,
            ),
            color: Theme.of(context).primaryColor,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              try {
                await Provider.of<Products>(
                  context,
                  listen: false,
                ).deleteProduct(product.id);
              } catch (error) {
                scaffold.showSnackBar(
                  SnackBar(
                    content: Text(error.toString()),
                  ),
                );
              }
            },
            color: Theme.of(context).errorColor,
          ),
        ]),
      ),
    );
  }
}
