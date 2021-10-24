import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart({Key key, this.recentTransactions}) : super(key: key);

  List<Map<String, Object>> get transactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalAmount = 0;

      for (var trx in recentTransactions) {
        bool isSameDay = weekDay.day == trx.date.day;
        bool isSameMonth = weekDay.month == trx.date.month;
        bool isSameYear = weekDay.year == trx.date.year;

        if (isSameDay && isSameMonth && isSameYear) {
          totalAmount += trx.amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay),
        'amount': totalAmount,
      };
    });
  }

  double get maxAmount {
    return recentTransactions.fold(0.0, (previousValue, transaction) {
      return previousValue + transaction.amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(transactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: transactionValues.map((ele) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                title: ele['day'],
                amount: ele['amount'],
                percentage:
                    maxAmount == 0 ? 0 : (ele['amount'] as double) / maxAmount,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
