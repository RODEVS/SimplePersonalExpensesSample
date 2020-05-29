import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:personal_expenses/models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transactionItem;
  final Function removeItem;

  TransactionItem({@required this.transactionItem, @required this.removeItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
                child: Text('\$${transactionItem.amount.toStringAsFixed(2)}')),
          ),
          radius: 30,
        ),
        title: Text(transactionItem.title),
        subtitle: Text(
          DateFormat().format(transactionItem.date),
          style: TextStyle(fontSize: 8, color: Colors.grey),
        ),
        trailing: IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () => this.removeItem(transactionItem.id),
            )          
      ),
    );
  }
}
