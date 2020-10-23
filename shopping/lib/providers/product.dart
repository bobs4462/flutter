import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shopping/exceptions/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;
  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite: false,
  });

  static const String url = 'https://shopping-6434b.firebaseio.com/';

  Future<void> toggleFavorite(String authToken) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    try {
      final response = await http.patch(
        url + 'products/$id.json' + '?auth=$authToken',
        body: json.encode({'isFavorite': isFavorite}),
      );
      if (response.statusCode >= 400) {
        throw HttpException('Could not toggle favorite');
      }
    } catch (error) {
      isFavorite = oldStatus;
    } finally {
      notifyListeners();
    }
  }
}
