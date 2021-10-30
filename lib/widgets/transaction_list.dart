import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteFunc;

  const TransactionList({
    Key key,
    this.transactions,
    this.deleteFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);

    return transactions.isEmpty
        ? Column(
            children: [
              SizedBox(height: 10),
              Text('No transaction yet!'),
              SizedBox(height: 20),
              Container(
                height: 200,
                child: Image.asset('assets/images/waiting.png'),
              ),
            ],
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 8,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text(
                            '\$${transactions[index].amount.toStringAsFixed(2)}'),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: theme.textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat().format(transactions[index].date),
                  ),
                  trailing: mediaQuery.size.width > 400
                      ? TextButton.icon(
                          onPressed: () => deleteFunc(transactions[index].id),
                          icon: Icon(
                            Icons.delete,
                            color: theme.errorColor,
                          ),
                          label: Text(
                            'Delete',
                            style: TextStyle(
                              color: theme.errorColor,
                            ),
                          ),
                        )
                      : IconButton(
                          onPressed: () => deleteFunc(transactions[index].id),
                          icon: Icon(Icons.delete),
                          color: theme.errorColor,
                        ),
                ),
              );
            },
          );
  }
}
