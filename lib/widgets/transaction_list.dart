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
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index) {
          return TransactionItem(
            transaction: transactions[index],
            deleteTrx: deleteTrx,
          );
        },
      ),
    );
  }
}
