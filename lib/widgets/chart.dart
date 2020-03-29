import '../widgets/chart_bar.dart';

import '../models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<TransactionModel> recentTransaction;

  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedTrxValue {


    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      var totalSum = 0.0;
      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDay.day &&
            recentTransaction[i].date.month == weekDay.month &&
            recentTransaction[i].date.year == weekDay.year) {
          totalSum += recentTransaction[i].amount;

        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedTrxValue.fold(0.0, (sum, item) {
      return (sum + item['amount']) > 0.0 ? (sum + item['amount']) : 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: groupedTrxValue.map((trx) {
          return Flexible(
            fit: FlexFit.tight,
            child: ChartBar(
              trx['day'],
              trx['amount'],
              (maxSpending <= 0.0
                  ? 0.0
                  : (trx['amount'] as double) / maxSpending),
            ),
          );
        }).toList(),
      ),
    );
  }
}
