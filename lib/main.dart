import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/new_transaction.dart';
import 'package:expense_tracker/widgets/transaction_list.dart';
import 'package:expense_tracker/widgets/user_transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Card(
              color: Colors.blue,
              child: Text('Chart'),
              elevation: 15,
            ),
          ),
          UserTransaction(),
        ],
      ),
    );
  }
}
