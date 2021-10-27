import 'package:flutter/material.dart';

import 'models/transaction.dart';

final List<Transaction> transactions = [
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

const transactionTitleStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 16,
  color: Colors.black,
);

const transactionDateStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 15,
  color: Colors.grey,
);

var appTheme = ThemeData(
  primarySwatch: Colors.green,
  accentColor: Colors.greenAccent,
  fontFamily: 'Quicksand',
  textTheme: textTheme,
  appBarTheme: appBarTheme,
);

var textTheme = ThemeData.light().textTheme.copyWith(
      headline6: TextStyle(
        fontFamily: 'OpenSans',
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      button: TextStyle(
        color: Colors.white,
      ),
    );

var appBarTheme = AppBarTheme(
  textTheme: ThemeData.light().textTheme.copyWith(
        headline6: TextStyle(
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
);
