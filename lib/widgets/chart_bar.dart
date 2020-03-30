import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, contrains) {
      return Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: contrains.maxHeight * 0.05),
            height: contrains.maxHeight * 0.1,
            child: FittedBox(
              child: Text('\$${spendingAmount.toStringAsFixed(0)}')
            ),
          ),
          SizedBox(
            height: contrains.maxHeight * 0.05,
          ),
          Container(
            height: contrains.maxHeight * 0.6,
            width: 10,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(20)),
                ),
                FractionallySizedBox(
                  heightFactor:
                      spendingPctOfTotal <= 0.0 ? 0.0 : spendingPctOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: contrains.maxHeight * 0.05,
          ),
          Container(
            height: contrains.maxHeight * 0.1,
            child: FittedBox(child: Text(label.toString())),
          )
        ],
      );
    });
  }
}
