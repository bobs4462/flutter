import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/auth.dart';
import 'package:shopping/providers/cart.dart';
import 'package:shopping/providers/product.dart';
import 'package:shopping/screens/product_details.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    final Cart cart = Provider.of<Cart>(ctx);
    final Product product = Provider.of<Product>(ctx, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(ctx).pushNamed(
              ProductDetailsScreen.route,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          leading: Consumer<Product>(
            builder: (ctx, product, child) => Consumer<Auth>(
              builder: (ctx, auth, child) => IconButton(
                icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border,
                ),
                onPressed: () {
                  product.toggleFavorite(auth.token, auth.userId);
                },
                color: Theme.of(ctx).accentColor,
              ),
            ),
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(
                productId: product.id,
                title: product.title,
                price: product.price,
                quantity: 1,
              );
              Scaffold.of(ctx).hideCurrentSnackBar();
              Scaffold.of(ctx).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 2),
                  content: Text('Item ${product.title} is added to cart'),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cart.undoLastAddition(product.id);
                    },
                  ),
                ),
              );
            },
            color: Theme.of(ctx).accentColor,
          ),
          backgroundColor: Colors.black87,
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
