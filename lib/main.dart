import './widgets/chart.dart';

import './widgets/transaction_list.dart';

import './models/transaction_model.dart';
import './widgets/add_transaction.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.purple,
        fontFamily: 'OpenSans',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                button: TextStyle(
                  color: Colors.white,
                ),
              ),
        ),
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<TransactionModel> transactions = [];

  bool _showChart = false;

  List<TransactionModel> get _recentTransaction {
    return transactions.where((trx) {
      // Hanya menghitung list yang waktu di buatnya dari 7 hari yang lalu
      return trx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addTransaction(
      String titleAdd, double amountAdd, DateTime dateSelected) {
    final addTrx = TransactionModel(
      id: DateTime.now().toString(),
      title: titleAdd,
      amount: amountAdd,
      date: dateSelected,
    );

    setState(() {
      transactions.add(addTrx);
      print('add trx jalan');
    });
  }

  void _deleteTrx(String id) {
    print('delete trx jalan $id');
    setState(() {
      transactions.removeWhere((trx) => trx.id == id);
    });
  }

  void modalAddTransaction(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true, // Membiarkan modal melayang ketika keryboard aktif
      context: ctx,
      builder: (_) {
        return GestureDetector(
          child: AddTransaction(
            addFunction: _addTransaction,
          ),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    final mediaQuery = MediaQuery.of(context);

    final isLanscape =
       mediaQuery.orientation == Orientation.landscape;

    final AppBar appBar = AppBar(
      title: Text(
        'Personal Expanses',
        style: TextStyle(
          fontFamily: 'QuickSand',
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            modalAddTransaction(context);
          },
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // SWITCH
            if (isLanscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Show Chart'),
                  Switch(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  ),
                ],
              ),
            // END SWITCH

            (_showChart || !isLanscape)
                // Chart
                ? Container(
                    height: (mediaQuery.size.height -
                            mediaQuery.padding.top -
                            appBar.preferredSize.height) *
                        0.3,
                    width: double.infinity,
                    child: Chart(_recentTransaction),
                  )
                // End Chart
                : Container(),

            // Transaction List
            Container(
              height: (mediaQuery.size.height -
                      mediaQuery.padding.top -
                      appBar.preferredSize.height) *
                  0.7,
              child: transactions.isEmpty
                  ? LayoutBuilder(
                      builder: (contex, contrains) {
                        return Column(
                          children: <Widget>[
                            Text(
                              'No Data',
                              style: Theme.of(context).textTheme.title,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: contrains.maxHeight * 0.6,
                              child: Image.asset(
                                'assets/images/waiting.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        );
                      },
                    )
                  : TransactionList(
                      transactions: transactions,
                      deleteTrx: _deleteTrx,
                    ),
            ),
            // End Transaction List
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          return _addTransaction;
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
