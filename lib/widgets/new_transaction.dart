import 'package:expense_tracker/widgets/adaptive_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction({Key key, this.addTransaction}) : super(key: key);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            left: 10,
            top: 10,
            right: 10,
            bottom: mediaQuery.viewInsets.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onSubmitted: (_) => _submit(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(selectedDate == null
                          ? 'No date chosen!'
                          : '${DateFormat().format(selectedDate)}'),
                    ),
                    AdaptiveButton(
                      title: "Choose Date",
                      handler: _showDatePicker,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _submit,
                child: Text('Add'),
                style: TextButton.styleFrom(
                  primary: theme.textTheme.button.color,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    var enteredTitle = titleController.text;
    var enteredAmount = double.tryParse(amountController.text);

    if (enteredAmount == null || selectedDate == null) {
      return;
    }
    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    widget.addTransaction(
      enteredTitle,
      enteredAmount,
      selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      if (selectedDate != null) {
        selectedDate = pickedDate.add(Duration(
          hours: selectedDate.hour,
          minutes: selectedDate.minute,
        ));
        _showTimePicker();
        return;
      }
      selectedDate = pickedDate;
      _showTimePicker();
    });
  }

  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((pickedTime) {
      setState(() {
        if (pickedTime == null) {
          return;
        }
        selectedDate = selectedDate.add(
          Duration(hours: pickedTime.hour, minutes: pickedTime.minute),
        );
      });
    });
  }
}
