import 'package:flutter/material.dart';
import 'package:shopping/providers/product.dart';

class UserProductItem extends StatelessWidget {
  final Product product;
  UserProductItem(this.product);
  @override
  Widget build(BuildContext context) {
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
            onPressed: null,
            color: Theme.of(context).primaryColor,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: null,
            color: Theme.of(context).errorColor,
          ),
        ]),
      ),
    );
  }
}
