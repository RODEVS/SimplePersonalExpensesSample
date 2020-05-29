import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/widgets/chartBar.dart';

class TransactionsChart extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionsChart({this.transactions});

  List<Map<String, Object>> get groupedTransactionsSum {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      var totalSum = 0.0;

      for (int i = 0; i < transactions.length; i++) {
        if (transactions[i].date.day == weekDay.day &&
            transactions[i].date.month == weekDay.month &&
            transactions[i].date.year == weekDay.year) {
          totalSum += transactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get spendingAmount {
    return groupedTransactionsSum.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionsSum.map((data) {
            return Expanded(
              child: ChartBar(
                  groupedTransaction: data,
                  spendingPct: (data['amount'] == 0.0)
                      ? 0.0
                      : ((data['amount'] as double) / spendingAmount)
                  ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
