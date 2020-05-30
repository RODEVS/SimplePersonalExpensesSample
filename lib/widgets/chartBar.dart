import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final Map<String, Object> groupedTransaction;
  final double spendingPct;

  ChartBar({@required this.groupedTransaction, @required this.spendingPct});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Container(
              height: 20,
              padding: EdgeInsets.all(2),
              child: FittedBox(
                  child: Text(
                    '\$${this.groupedTransaction['amount']}', 
                    style: Theme.of(context).textTheme.headline6,
                  ),
                )
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 60,
            width: 15,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(110, 110, 110, 0.10),
                    border: Border.all(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: this.spendingPct,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      border: Border.all(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            this.groupedTransaction['day'].toString(), 
            style: Theme.of(context).textTheme.headline6,)
        ],      
    );
  }
}
