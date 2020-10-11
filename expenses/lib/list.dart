import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> list;
  final Function delete;
  TransactionList(this.list, this.delete);

  @override
  Widget build(BuildContext ctx) {
    List<Widget> transactions = list
        .map(
          (tx) => Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 7, horizontal: 4),
            child: ListTile(
              leading: CircleAvatar(
                radius: 35,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: FittedBox(
                    child: Text(
                      '\$${tx.amount.toStringAsFixed(2)}',
                    ),
                  ),
                ),
              ),
              title: Text(
                tx.description,
                style: Theme.of(ctx).textTheme.headline6,
              ),
              subtitle: Text(DateFormat.yMMMd().format(tx.date)),
              trailing: IconButton(
                  icon: Icon(Icons.delete),
                  color: Theme.of(ctx).errorColor,
                  onPressed: () => delete(tx.id)),
            ),
          ),
        )
        .toList();
    return Container(
      height: 700,
      child: ListView(padding: EdgeInsets.all(5), children: transactions),
    );
  }
}
