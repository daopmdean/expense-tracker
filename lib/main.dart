import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/chart.dart';
import 'package:expense_tracker/widgets/new_transaction.dart';
import 'package:expense_tracker/widgets/transaction_list.dart';
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
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.greenAccent,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button: TextStyle(
                color: Colors.white,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      id: '1',
      title: 'Food',
      amount: 12.45,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: '2',
      title: 'Drink',
      amount: 4.2,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: '3',
      title: 'Cloth',
      amount: 8.99,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: '4',
      title: 'Book',
      amount: 35.49,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: '5',
      title: 'Pen',
      amount: 12,
      date: DateTime.now().subtract(Duration(days: 5)),
    ),
    Transaction(
      id: '6',
      title: 'Phone',
      amount: 45.99,
      date: DateTime.now().subtract(Duration(days: 6)),
    ),
  ];

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expense Tracker',
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => startNewTransaction(context),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Chart(
              recentTransactions: _recentTransactions,
            ),
          ),
          TransactionList(
            transactions: _transactions,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startNewTransaction(context),
      ),
    );
  }

  void startNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return NewTransaction(addTransaction: _newTransaction);
      },
    );
  }

  void _newTransaction(String title, double amount) {
    var uuid = Uuid();
    var transaction = Transaction(
      id: uuid.v1(),
      title: title,
      amount: amount,
      date: DateTime.now(),
    );

    setState(() {
      _transactions.add(transaction);
    });
  }
}
