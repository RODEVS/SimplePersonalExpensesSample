import 'package:flutter/material.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/widgets/TransactionItem.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function removeTransaction;

  TransactionsList({this.transactions, this.removeTransaction});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: (transactions.isEmpty)
            ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[                  
                  Container(
                      height: 200,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      )
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Text(
                    'No transactions yet',
                    style: Theme.of(context).textTheme.title,
                  ),
                ],
                
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return TransactionItem(
                      transactionItem: transactions[index],
                      removeItem: this.removeTransaction,
                  );
                },
                itemCount: transactions.length,
              ),
      ),
    );
  }
}
