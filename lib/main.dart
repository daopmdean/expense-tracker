import 'dart:io';

import 'package:expense_tracker/constants.dart';
import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/chart.dart';
import 'package:expense_tracker/widgets/new_transaction.dart';
import 'package:expense_tracker/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = transactions;
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions
        .where(
          (trx) => trx.date.isAfter(
            DateTime.now().subtract(
              Duration(days: 7),
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = Platform.isAndroid
        ? AppBar(
            title: Text(
              'Expense Tracker',
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => startNewTransaction(context),
              ),
            ],
          )
        : CupertinoNavigationBar(
            middle: Text(
              'Expense Tracker',
            ),
            trailing: GestureDetector(
              child: Icon(Icons.add),
              onTap: () => startNewTransaction(context),
            ),
          );

    final appHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final listTxsWidget = Container(
      height: appHeight * 0.7,
      child: TransactionList(
        transactions: _transactions,
        deleteFunc: _deleteTransaction,
      ),
    );

    final bodyContent = SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Show chart',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Switch.adaptive(
                  value: _showChart,
                  onChanged: (val) {
                    setState(() {
                      _showChart = val;
                    });
                  },
                )
              ],
            ),
          if (isLandscape && _showChart)
            Container(
              height: appHeight * 0.6,
              width: double.infinity,
              child: Chart(
                recentTransactions: _recentTransactions,
              ),
            ),
          if (isLandscape && !_showChart) listTxsWidget,
          if (!isLandscape)
            Container(
              height: appHeight * 0.25,
              width: double.infinity,
              child: Chart(
                recentTransactions: _recentTransactions,
              ),
            ),
          if (!isLandscape) listTxsWidget,
        ],
      ),
    );

    return Platform.isAndroid
        ? Scaffold(
            appBar: appBar,
            body: bodyContent,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isAndroid
                ? FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => startNewTransaction(context),
                  )
                : Container(),
          )
        : CupertinoPageScaffold(
            child: bodyContent,
            navigationBar: appBar,
          );
  }

  void startNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder: (_) {
        return NewTransaction(addTransaction: _newTransaction);
      },
    );
  }

  void _newTransaction(String title, double amount, DateTime dateTime) {
    var uuid = Uuid();
    var transaction = Transaction(
      id: uuid.v1(),
      title: title,
      amount: amount,
      date: dateTime,
    );

    setState(() {
      _transactions.add(transaction);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((trx) => trx.id == id);
    });
  }
}
