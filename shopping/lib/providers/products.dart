import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shopping/exceptions/http_exception.dart';
import 'package:shopping/providers/product.dart';

class Products with ChangeNotifier {
  static const String url = 'https://shopping-6434b.firebaseio.com/';
  // bool _favoritesOnly = false;
  String authToken;
  List<Product> _items = [];
  void update(String authToken, List<Product> items) {
    this.authToken = authToken;
    this._items = items;
  }

  int get itemCount {
    return _items.length;
  }

  List<Product> get items {
    // if (_favoritesOnly) {
    //   return _items.where((i) => i.isFavorite).toList();
    // } else {
    return [..._items];
    // }
  }

  Future<void> addProduct(Product product) {
    return http
        .post(
      url + 'products.json' + '?auth=$authToken',
      body: json.encode({
        'title': product.title,
        'description': product.description,
        'price': product.price,
        'isFavorite': product.isFavorite,
        'imageUrl': product.imageUrl,
      }),
    )
        .then(
      (response) {
        final Product dummy = Product(
          id: json.decode(response.body)['name'],
          price: product.price,
          title: product.title,
          description: product.description,
          imageUrl: product.imageUrl,
        );
        _items.add(dummy);
        notifyListeners();
      },
    );
  }

  Future<void> deleteProduct(String id) async {
    final int index = _items.indexWhere((p) => p.id == id);
    Product product = _items[index];
    _items.removeAt(index);
    http
        .delete(
      url + 'products/$id.json' + '?auth=$authToken',
    )
        .then((response) {
      if (response.statusCode >= 400) {
        throw HttpException('Could not delete\n' + response.body);
      }
      product = null;
    }).catchError((error) {
      _items.insert(index, product);
      throw error;
    });
    notifyListeners();
  }

  Future<void> editProduct(Product product) async {
    final int index = _items.indexWhere((p) => p.id == product.id);
    if (index > -1) {
      await http.patch(
        url + 'products/${product.id}.json' + '?auth=$authToken',
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'isFavorite': product.isFavorite,
          'imageUrl': product.imageUrl,
        }),
      );
      _items[index] = product;
    }
    notifyListeners();
  }

  Future<void> fetchProducts() async {
    final response = await http.get(url + 'products.json' + '?auth=$authToken');
    final responseJson = json.decode(response.body) as Map<String, dynamic>;
    if (responseJson == null) {
      return;
    }
    List<Product> list = [];
    responseJson.forEach((id, data) {
      list.add(Product(
        id: id,
        title: data['title'],
        price: data['price'],
        imageUrl: data['imageUrl'],
        description: data['description'],
        isFavorite: data['isFavorite'],
      ));
    });
    _items = list;
    notifyListeners();
  }

  Product getProductById(String id) {
    return _items.firstWhere((i) => i.id == id);
  }

  List<Product> showFavoritesOnly() {
    return _items.where((i) => i.isFavorite).toList();
  }
  // void showAll() {}
}

// List<Product> _items = [
//   Product(
//     id: 'p1',
//     title: 'Red Shirt',
//     description: 'A red shirt - it is pretty red!',
//     price: 29.99,
//     imageUrl:
//         'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
//   ),
//   Product(
//     id: 'p2',
//     title: 'Trousers',
//     description: 'A nice pair of trousers.',
//     price: 59.99,
//     imageUrl:
//         'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
//   ),
//   Product(
//     id: 'p3',
//     title: 'Yellow Scarf',
//     description: 'Warm and cozy - exactly what you need for the winter.',
//     price: 19.99,
//     imageUrl: 'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
//   ),
//   Product(
//     id: 'p4',
//     title: 'A Pan',
//     description: 'Prepare any meal you want.',
//     price: 49.99,
//     imageUrl:
//         'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
//   ),
// ];
