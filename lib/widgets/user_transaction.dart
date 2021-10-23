import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import './new_transaction.dart';
import './transaction_list.dart';

class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> _transactions = [
    Transaction(id: '1', title: 'Food', amount: 12, date: DateTime.now()),
    Transaction(id: '2', title: 'Drink', amount: 4, date: DateTime.now())
  ];

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(addTransaction: _newTransaction),
        TransactionList(
          transactions: _transactions,
        ),
      ],
    );
  }
}
