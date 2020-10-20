import 'package:flutter/foundation.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = Map();

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    return _items.values.fold(
      0.0,
      (sum, item) => sum + item.quantity,
    );
  }

  double get totalSum {
    return _items.values.fold(
      0.0,
      (sum, item) => sum + item.price * item.quantity,
    );
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void undoLastAddition(String productId) {
    if (_items[productId].quantity > 1) {
      _items[productId].quantity -= 1;
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void addItem({
    String productId,
    String title,
    double price,
    int quantity = 1,
  }) {
    if (_items.containsKey(productId)) {
      _items[productId].quantity += 1;
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
            id: DateTime.now().toString(),
            title: title,
            price: price,
            quantity: quantity),
      );
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}

class CartItem {
  final String id;
  final String title;
  int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}
