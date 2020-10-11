import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'transaction.dart';

class NewTransation extends StatefulWidget {
  final Function addTransaction;

  NewTransation(this.addTransaction);

  @override
  _NewTransationState createState() => _NewTransationState();
}

class _NewTransationState extends State<NewTransation> {
  final _descriptionController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime _date;
  void _pickDate() {
    showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),
    ).then((date) {
      if (date != null) {
        setState(() => _date = date);
      }
    });
  }

  Widget build(BuildContext ctx) {
    return Card(
        child: Container(
          padding: EdgeInsets.all(9),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'description'),
                controller: _descriptionController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(_date != null
                          ? 'Date picked: ${DateFormat.yMEd().format(_date)}'
                          : 'No date picked'),
                    ),
                    RaisedButton(
                      color: Theme.of(ctx).buttonColor,
                      child: Text('Pick a date'),
                      onPressed: _pickDate,
                    ),
                  ],
                ),
              ),
              RaisedButton(
                child: Text('Add transaction'),
                onPressed: () {
                  widget.addTransaction(
                    Transaction(
                        amount: (double.parse(_amountController.text)),
                        date: _date,
                        description: _descriptionController.text),
                  );
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        ),
        elevation: 4);
  }
}
