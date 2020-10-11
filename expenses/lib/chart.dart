import 'package:flutter/material.dart';
import 'transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupped {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: (6 - index)),
      );
      double total = 0.0;
      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          total += recentTransactions[i].amount;
        }
      }
      return {
        'weekDay': DateFormat.E().format(weekDay),
        'amount': total,
      };
    });
  }

  @override
  Widget build(BuildContext ctx) {
    double total = recentTransactions.fold(0.0, (sum, tx) => sum + tx.amount);
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: Card(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: groupped
                .map((tx) => Gauge(
                    total: total, amount: tx['amount'], weekday: tx['weekDay']))
                .toList()),
        elevation: 5,
      ),
    );
  }
}

class Gauge extends StatelessWidget {
  final double total;
  final double amount;
  final String weekday;
  Gauge({@required this.total, @required this.amount, @required this.weekday});

  @override
  Widget build(BuildContext ctx) {
    return Column(
      children: [
        Text('\$$amount'),
        SizedBox(height: 5),
        Container(
          height: 90,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  border: Border.all(color: Colors.cyan),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: total != 0.0 ? amount / total : 0.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(ctx).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Text(
          weekday, //weekday.substring(0, 1),
        ),
      ],
    );
  }
}
