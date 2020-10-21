import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shopping/providers/cart.dart';
import 'package:http/http.dart' as http;

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  static const String url = 'https://shopping-6434b.firebaseio.com/';

  Future<void> fetchOrders() {
    return http.get(url + 'orders.json').then((response) {
      final Map<String, dynamic> ordersJson = json.decode(response.body);
      if (ordersJson == null) {
        return;
      }
      List<OrderItem> orders = [];
      ordersJson.forEach((id, data) {
        print(data['cartItems']);
        orders.add(OrderItem(
          id: id,
          amount: data['amount'],
          date: DateTime.parse(data['date']),
          cartItems: (data['cartItems'] as List<dynamic>)
              .reversed
              .map((j) => CartItem(
                    id: j['id'],
                    title: j['title'],
                    quantity: j['quantity'],
                    price: j['price'],
                  ))
              .toList(),
        ));
      });
      _orders = orders;
      notifyListeners();
    });
  }

  Future<void> addOrder(List<CartItem> items, double total) {
    final date = DateTime.now();
    return http
        .post(url + 'orders.json',
            body: json.encode({
              'amount': total,
              'date': date.toIso8601String(),
              'cartItems': items
                  .map((i) => {
                        'id': i.id,
                        'title': i.title,
                        'quantity': i.quantity,
                        'price': i.price,
                      })
                  .toList(),
            }))
        .then((response) {
      _orders.add(OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        cartItems: items,
        date: date,
      ));
      notifyListeners();
    });
  }
}

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> cartItems;
  final DateTime date;
  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.cartItems,
    @required this.date,
  });
}
