import 'package:flutter/material.dart';
import 'transaction.dart';
import 'list.dart';
import 'new.dart';
import 'chart.dart';

void main() {
  runApp(ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.orange,
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontSize: 19,
              ),
              button: TextStyle(
                fontSize: 17,
              ),
            ),
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(title: 'My expenses'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Transaction> _transactions = [
    Transaction(amount: 12, description: 'Laptop', date: DateTime.now()),
    Transaction(amount: 12, description: 'Laptop', date: DateTime.now()),
    Transaction(amount: 12, description: 'Laptop', date: DateTime.now()),
  ];
  void _addTransaction(Transaction tx) {
    print(tx);
    setState(() {
      _transactions.add(tx);
    });
  }

  void _deleteTransaction(int id) {
    setState(() {
      _transactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _beginTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (ctx) {
          return NewTransation(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Chart(
              _transactions
                  .where((tx) => tx.date
                      .isAfter(DateTime.now().subtract(Duration(days: 7))))
                  .toList(),
            ),
            _transactions.isNotEmpty
                ? TransactionList(_transactions, _deleteTransaction)
                : Text('OOPS'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _beginTransaction(context),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
