import 'package:flutter/material.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/widgets/newTransaction.dart';
import 'package:personal_expenses/widgets/transactionsList.dart';
import 'package:personal_expenses/widgets/transactionsChart.dart';

class MainContent extends StatefulWidget {
  @override
  _MainContentState createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  final List<Transaction> transactions = [
    // Transaction(id: 'id1', title: 'Shoes', amount: 700, date: DateTime.now()),
    // Transaction(id: 'id2', title: 'Laptop', amount: 200, date: DateTime.now()),
  ];

  List<Transaction> get _recentTransactions {
    return transactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7)
        )
      );
    }).toList();
  }

  void addTransaction(Transaction newTransaction) {
    setState(() {
      transactions.add(newTransaction);
    });
  }

  void startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,

      builder: (_) {
        return Container(
          margin: EdgeInsets.only(top: 40),
          color: Colors.transparent,          
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20)
              )
            ),
            child: NewTransaction(
              transaction: addTransaction,
            ),
          ),
        );
      },
    );
  }

  void removeTransaction(String id) {
    setState(() {
      transactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => startAddNewTransaction(context),
          )
        ],
      ),
      body: Container(
        color: Color.fromRGBO(250, 250, 250, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TransactionsChart(transactions: _recentTransactions),
            TransactionsList(transactions: transactions, removeTransaction: this.removeTransaction,)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startAddNewTransaction(context),
      ),
    );
  }
}
