import 'package:flutter/material.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function transaction;

  NewTransaction({this.transaction});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _choosenDate = DateTime.now();

  void _confirmTransaction() {
    if (titleController.text.isEmpty ||
        double.parse(amountController.text) <= 0) return;

    widget.transaction(Transaction(
        id: DateTime.now().millisecond.toString(),
        title: titleController.text,
        amount: double.parse(amountController.text),
        date: _choosenDate));

    Navigator.of(context).pop();
  }

  void _showMyDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(Duration(days: 7)),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) return;

      setState(() {
        _choosenDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Title',
            ),
            controller: titleController,
            onSubmitted: (_) => _confirmTransaction(),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Amount',
            ),
            controller: amountController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onSubmitted: (_) => _confirmTransaction(),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: <Widget>[
                Text(
                  '${DateFormat('MMM/dd/yyyy').format(_choosenDate)}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                FlatButton(
                  child: Text('Choose Date',
                      style: TextStyle(color: Theme.of(context).primaryColor)),
                  onPressed: _showMyDatePicker,
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
              child: Text(
                'Add Transaction',
              ),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: () => _confirmTransaction()),
        ],
      ),
    );
  }
}
