import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/cart.dart';
import 'package:shopping/providers/orders.dart';

class CartOverviewScreen extends StatelessWidget {
  static final String route = '/cart/overview';
  @override
  Widget build(BuildContext ctx) {
    final Cart cart = Provider.of(ctx);
    final items = cart.items.entries.toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Overview'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$ ${cart.totalSum}',
                      style: TextStyle(
                        color: Theme.of(ctx).primaryTextTheme.headline6.color,
                      ),
                    ),
                    backgroundColor: Theme.of(ctx).primaryColor,
                  ),
                  OrderButton(cart: cart),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return CartItemCard(items[index]);
              },
              itemCount: cart.itemCount,
            ),
          ),
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      textColor: Theme.of(context).primaryColor,
      child: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Text('Order now!'),
      onPressed: widget.cart.itemCount < 1
          ? null
          : () {
              setState(() {
                _isLoading = true;
              });
              Provider.of<Orders>(context, listen: false)
                  .addOrder(
                widget.cart.items.values.toList(),
                widget.cart.totalSum,
              )
                  .then((_) {
                _isLoading = false;
                widget.cart.clearCart();
              });
            },
    );
  }
}

class CartItemCard extends StatelessWidget {
  final MapEntry<String, CartItem> item;
  CartItemCard(this.item);
  @override
  Widget build(BuildContext ctx) {
    final Cart cart = Provider.of<Cart>(ctx, listen: false);
    return Dismissible(
      key: ValueKey(item.value.id),
      confirmDismiss: (DismissDirection dd) {
        return showDialog(
          context: ctx,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Confirm item removal from the cart'),
            actions: [
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
              ),
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
              ),
            ],
          ),
        );
      },
      background: Container(
        color: Theme.of(ctx).errorColor,
        child: Icon(
          Icons.delete,
          size: 40,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 15,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => cart.removeItem(item.key),
      child: Card(
        margin: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 15,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              radius: 41,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: FittedBox(
                  child: Text('\$${item.value.price.toStringAsFixed(2)}'),
                ),
              ),
            ),
            title: Text(item.value.title),
            subtitle:
                Text('Subtotal: \$${item.value.price * item.value.quantity}'),
            trailing: Text('${item.value.quantity} X'),
          ),
        ),
      ),
    );
  }
}
