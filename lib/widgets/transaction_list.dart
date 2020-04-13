import 'package:expans/widgets/transaction_item.dart';

import '../models/transaction_model.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<TransactionModel> transactions;
  final Function deleteTrx;

  TransactionList({this.transactions, this.deleteTrx});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          ...transactions.map((f) {
            return TransactionItem(
              key: ValueKey(f.id),
              transaction: f,
              deleteTrx: deleteTrx,
            );
          }).toList(),
        ],
      ),
    );
  }
}
