import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:spendingplanner/models/transaction.dart';

class TransactionCardTemplate extends StatefulWidget {
  final Transaction transaction;
  final Function deleteTransaction;
  final Function editTransaction;
  final Function showTransactionInfo;

  TransactionCardTemplate({
    Key key,
    this.transaction,
    this.deleteTransaction,
    this.editTransaction,
    this.showTransactionInfo,
  }) : super(key: key);

  @override
  _TransactionCardTemplateState createState() => _TransactionCardTemplateState();
}

class _TransactionCardTemplateState extends State<TransactionCardTemplate> {

  Color _priceColor;


  @override
  void initState() {
    const possibleColors = [Colors.blue, Colors.lightBlue, Colors.deepOrange, Colors.green];

    _priceColor = possibleColors[Random().nextInt(4)];
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Card(
      margin: EdgeInsets.all(10),
      elevation: 5,
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              width: 5,
              color: _priceColor,
            ),
          ),
          child: Text(
            '\$${widget.transaction.price.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _priceColor,
            ),
          ),
        ),
        title: Container(
          height: 27,
          child: FittedBox(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.transaction.title,
              style: Theme.of(context).textTheme.title,
            ),
          ),
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date),
        ),
        trailing: FittedBox(
          child: Row(
              children: mediaQuery.size.width < 600
                  ? <Widget>[
                      Container(),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.lightBlue,
                              width: 3,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        child: IconButton(
                          icon: Icon(
                            Icons.create,
                            color: Colors.lightBlue,
                          ),
                          onPressed: () => widget.showTransactionInfo(
                            context,
                            widget.transaction.title,
                            widget.transaction.price,
                            widget.transaction.date,
                            widget.transaction.id,
                            widget.editTransaction,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).errorColor,
                              width: 3,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        child: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).errorColor,
                          ),
                          onPressed: () {
                            widget.deleteTransaction(widget.transaction.id);
                          },
                        ),
                      ),
                    ]
                  : <Widget>[
                      Container(),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.lightBlue,
                              width: 3,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        child: FlatButton.icon(
                          icon: Icon(
                            Icons.create,
                          ),
                          label: Text('Edit'),
                          textColor: Colors.blue,
                          onPressed: () => widget.showTransactionInfo(
                            context,
                            widget.transaction.title,
                            widget.transaction.price,
                            widget.transaction.date,
                            widget.transaction.id,
                            widget.editTransaction,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).errorColor,
                              width: 3,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        child: FlatButton.icon(
                          icon: Icon(
                            Icons.delete,
                          ),
                          textColor: Theme.of(context).errorColor,
                          label: Text('Delete'),
                          onPressed: () {
                            widget.deleteTransaction(widget.transaction.id);
                          },
                        ),
                      ),
                    ]),
        ),
      ),
    );
  }
}
