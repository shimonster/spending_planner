import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class EditTransaction extends StatefulWidget {
  final BuildContext ctx;
  final String transactionTitle;
  final double transactionPrice;
  final DateTime transactionDate;
  final String transactionId;
  final List<Transaction> transactions;
  final Function editTransaction;

  EditTransaction(
      this.ctx,
      this.transactionTitle,
      this.transactionPrice,
      this.transactionDate,
      this.transactionId,
      this.transactions,
      this.editTransaction);

  @override
  _EditTransactionState createState() => _EditTransactionState(transactionDate);
}

class _EditTransactionState extends State<EditTransaction> {
  var _canEdit = false;
  var _newTitleController = TextEditingController();
  var _newPriceController = TextEditingController();
  var _currentDate;

  _EditTransactionState(this._currentDate);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
//      decoration: BoxDecoration(
//        border: Border.all(
//          color: Theme.of(widget.ctx).primaryColor,
//          width: 3,
//        ),us
//      ),
      child: _canEdit == false
          ? Container(
              height: 300,
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      widget.transactionTitle,
                      style: Theme.of(widget.ctx).textTheme.title.copyWith(
                            fontSize: 30,
                            color: Colors.blue,
                          ),
                    ),
                  ),
                  Container(
                    height: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          child: Text(
                            'Price: \$${widget.transactionPrice.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.subtitle,
                          ),
                        ),
                        Text(
                          'Date: ${DateFormat.yMd().format(widget.transactionDate)}',
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                        Text(
                          'ID: ${widget.transactionId}',
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                        child: Text(
                          'Edit',
                          style: Theme.of(context).textTheme.subtitle.copyWith(
                                fontSize: 20,
                              ),
                        ),
                        onPressed: () {
                          setState(() {
                            _canEdit = true;
                          });
                        },
                      ),
                      FlatButton(
                        child: Text(
                          'Ok',
                          style: Theme.of(context).textTheme.subtitle.copyWith(
                                fontSize: 20,
                              ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          setState(() {
                            _canEdit = false;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )
          : Column(
              children: <Widget>[
                TextField(
                  controller: _newTitleController,
                  decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle:
                          TextStyle(color: Theme.of(context).accentColor),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 10,
                          style: BorderStyle.solid,
                        ),
                      ),
                      hintText: 'Previous title:   ${widget.transactionTitle}'),
                ),
                TextField(
                  controller: _newPriceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Price',
                    labelStyle: TextStyle(color: Theme.of(context).accentColor),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 10,
                        style: BorderStyle.solid,
                      ),
                    ),
                    hintText:
                        'Previous price:   ${widget.transactionPrice.toStringAsFixed(2)}',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Text(DateFormat.yMd().format(_currentDate))),
                      FlatButton(
                        child: Text(
                          'Select New Date',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          showDatePicker(
                            context: widget.ctx,
                            initialDate: widget.transactionDate,
                            firstDate:
                                DateTime.now().subtract(Duration(days: 365)),
                            lastDate: DateTime.now(),
                          ).then((chosenDate) {
                            setState(() {
                              _currentDate = chosenDate;
                            });
                          });
                        },
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      child: Text(
                        'Cancel',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle
                            .copyWith(color: Theme.of(context).accentColor),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: Text(
                        'Ok',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle
                            .copyWith(color: Theme.of(context).accentColor),
                      ),
                      onPressed: () {
                        if (_newTitleController == null ||
                            _newPriceController == null ||
                            _currentDate == null) {
                          return;
                        }
                        widget.editTransaction(
                            widget.transactionId,
                            _newTitleController,
                            _newPriceController,
                            _currentDate);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                )
              ],
            ),
    );
  }
}
