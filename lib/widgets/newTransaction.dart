import 'dart:io';
import 'package:flutter/cupertino.dart';
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
            firstDate: DateTime.now().subtract(Duration(days: 6)),
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
    final titleButton = Platform.isAndroid
        ? TextField(
            decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: Theme.of(context).textTheme.headline6),
            controller: titleController,
            onSubmitted: (_) => _confirmTransaction(),
          )
        : CupertinoTextField(
            placeholder: 'Title',
            controller: titleController,
            onSubmitted: (_) => _confirmTransaction(),
          );

    final amountButton = Platform.isAndroid
        ? TextField(
            decoration: InputDecoration(
                labelText: 'Amount',
                labelStyle: Theme.of(context).textTheme.headline6),
            controller: amountController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onSubmitted: (_) => _confirmTransaction(),
          )
        : CupertinoTextField(
            placeholder: 'Amount',
            controller: amountController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onSubmitted: (_) => _confirmTransaction(),
          );

    final addTransactionButton = Platform.isAndroid
        ? RaisedButton(
            child: Text(
              'Add Transaction',
            ),
            color: Theme.of(context).primaryColor,
            textColor: Theme.of(context).textTheme.button.color,
            onPressed: () => _confirmTransaction())
        : CupertinoButton(
            child: Text('Add Transaction'),
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.only(left: 15, right: 15),
            onPressed: () => _confirmTransaction());

    final setDateComponent = Padding(
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
    );

    return Container(
      padding: EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          titleButton,
          SizedBox(
            height: 15,
          ),
          amountButton,
          SizedBox(
            height: 10,
          ),
          setDateComponent,
          SizedBox(
            height: 10,
          ),
          addTransactionButton,
        ],
      ),
    );
  }
}
