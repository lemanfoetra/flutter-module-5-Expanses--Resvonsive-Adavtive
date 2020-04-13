import 'dart:math';

import 'package:flutter/material.dart';
import '../models/transaction_model.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  final TransactionModel transaction;
  final Function deleteTrx;

  const TransactionItem({
    Key key,
    this.transaction,
    this.deleteTrx,
  }) : super(key: key);

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {

  Color _bgColor;

  @override
  void initState() {
    const availableColor = [
      Colors.red,
      Colors.green,
      Colors.blue,
    ];

    _bgColor = availableColor[Random().nextInt(3)];
    print('ramdom color begin');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('builddd jalan');
    return Card(
      child: Padding(
        padding: EdgeInsets.only(top: 2, bottom: 2),
        child: ListTile(
          leading: FittedBox(
            child: CircleAvatar(
              backgroundColor: _bgColor,
              radius: 30,
              child: Text(
                '\$${widget.transaction.amount}',
              ),
            ),
          ),
          title: Text(
            widget.transaction.title,
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(
            DateFormat.yMMMd().format(widget.transaction.date),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.delete,
              color: Theme.of(context).errorColor,
            ),
            onPressed: () {
              return widget.deleteTrx(widget.transaction.id);
            },
          ),
        ),
      ),
    );
  }
}
