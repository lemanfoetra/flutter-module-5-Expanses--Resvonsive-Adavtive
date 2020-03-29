import '../models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {


  final List<TransactionModel> transactions;
  final Function deleteTrx;

  TransactionList({this.transactions, this.deleteTrx});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index) {
          return Card(
            child: Padding(
              padding: EdgeInsets.only(top: 2, bottom: 2),
              child: ListTile(
                leading: FittedBox(
                  child: CircleAvatar(
                    radius: 30,
                    child: Text(
                      '\$${transactions[index].amount}',
                    ),
                  ),
                ),
                title: Text(
                  transactions[index].title,
                  style: Theme.of(context).textTheme.title,
                ),
                subtitle: Text(
                  DateFormat.yMMMd().format(transactions[index].date),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Theme.of(context).errorColor,), 
                  onPressed: (){
                    return deleteTrx(transactions[index].id);
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
