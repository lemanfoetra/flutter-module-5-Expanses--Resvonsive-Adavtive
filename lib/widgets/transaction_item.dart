import 'package:flutter/material.dart';
import '../models/transaction_model.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  final TransactionModel transaction;
  final Function deleteTrx;

  const TransactionItem({
    Key key,
    this.transaction,
    this.deleteTrx,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(top: 2, bottom: 2),
        child: ListTile(
          leading: FittedBox(
            child: CircleAvatar(
              radius: 30,
              child: Text(
                '\$${transaction.amount}',
              ),
            ),
          ),
          title: Text(
            transaction.title,
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(
            DateFormat.yMMMd().format(transaction.date),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.delete,
              color: Theme.of(context).errorColor,
            ),
            onPressed: () {
              return deleteTrx(transaction.id);
            },
          ),
        ),
      ),
    );
  }
}
