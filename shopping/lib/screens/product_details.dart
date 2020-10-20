import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/products.dart';
import 'package:shopping/providers/product.dart';

class ProductDetailsScreen extends StatelessWidget {
  static final String route = '/product/details';
  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context).settings.arguments as String;
    final Product product =
        Provider.of<Products>(context, listen: false).getProductById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text('${product.title} details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 400,
              width: double.infinity,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '\$${product.price}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                '${product.description}',
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
