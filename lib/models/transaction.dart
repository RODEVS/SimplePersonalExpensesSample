import 'package:flutter/foundation.dart';

class Transaction {
  String id;
  String title;
  double amount;
  DateTime date;

  Transaction({
      @required this.id,
      @required this.title,
      @required this.amount,
      @required this.date
  });

  Transaction.empty();

  @override
  String toString() {
    return 'id: ${this.id}, title: ${this.title}, amount: ${this.amount}, date: ${this.date.toString()}';
  }
}
