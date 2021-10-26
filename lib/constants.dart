import 'package:flutter/material.dart';

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
