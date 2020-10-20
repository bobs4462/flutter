import 'package:flutter/foundation.dart';
import 'package:shopping/providers/cart.dart';

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> items, double total) {
    _orders.add(OrderItem(
      id: DateTime.now().toString(),
      amount: total,
      cartItems: items,
      date: DateTime.now(),
    ));
    notifyListeners();
  }
}

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> cartItems;
  final DateTime date;
  OrderItem({this.id, this.amount, this.cartItems, this.date});
}
