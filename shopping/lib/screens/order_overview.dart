import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/orders.dart';
import 'package:shopping/widgets/drawer.dart';

class OrdersOverviewScreen extends StatelessWidget {
  static final String route = '/orders/overview';
  @override
  Widget build(BuildContext context) {
    final List<OrderItem> orders = Provider.of<Orders>(context).orders;
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders overview'),
      ),
      drawer: MainDrawer(),
      body: ListView.builder(
        itemBuilder: (ctx, i) => OrderItemCard(orders[i]),
        itemCount: orders.length,
      ),
    );
  }
}

class OrderItemCard extends StatefulWidget {
  final OrderItem orderItem;
  OrderItemCard(this.orderItem);

  @override
  _OrderItemCardState createState() => _OrderItemCardState();
}

class _OrderItemCardState extends State<OrderItemCard> {
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.orderItem.amount}'),
            subtitle: Text(
              DateFormat('dd-MM-yyyy hh:mm').format(widget.orderItem.date),
            ),
            trailing: IconButton(
                icon: Icon(expanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    expanded = !expanded;
                  });
                }),
          ),
          if (expanded)
            Container(
              child: ListView.builder(
                itemBuilder: (ctx, i) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.orderItem.cartItems[i].title,
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${widget.orderItem.cartItems[i].quantity} X \$${widget.orderItem.cartItems[i].price}',
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                itemCount: widget.orderItem.cartItems.length,
              ),
              height: min(widget.orderItem.cartItems.length * 20.0 + 10.0, 190),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            ),
        ],
      ),
    );
  }
}
