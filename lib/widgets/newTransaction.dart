import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import './adaptiveFlatButton_IOS_Android.dart';



class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  DateTime _chosenDate;

  void _submitTransactionInfo() {
    final _enteredTitle = titleController.text;
    final _enteredPrice = double.parse(priceController.text);

    if (_enteredTitle.isEmpty || _enteredPrice == null || _chosenDate == null) {
      return;
    }

    widget.addTransaction(
      _enteredTitle,
      _enteredPrice,
      _chosenDate,
    );

    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _chosenDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 20,
            right: 20,
            left: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2)
                ),
                  labelStyle: TextStyle(color: Theme.of(context).accentColor),
                  labelText: 'Title',
                ),
                controller: titleController,
                onSubmitted: (_) => _submitTransactionInfo(),
              ),
              TextField(
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2)
                  ),
                  labelText: 'Price',
                  labelStyle: TextStyle(color: Theme.of(context).accentColor),
                ),
                controller: priceController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitTransactionInfo(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(_chosenDate == null
                          ? 'No Date Selected'
                          : 'Date: ${DateFormat.yMd().format(_chosenDate)}'),
                    ),
                    AdaptiveFlatButton('Select Date', _showDatePicker)
                  ],
                ),
              ),
              FlatButton(
                      child: Text(
                        'Add Transaction',
                        style: Theme.of(context).textTheme.button.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      onPressed: _submitTransactionInfo),
            ],
          ),
        ),
      ),
    );
  }
}
