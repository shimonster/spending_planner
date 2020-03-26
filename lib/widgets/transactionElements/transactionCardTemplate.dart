import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:spendingplanner/models/transaction.dart';

class TransactionCardTemplate extends StatelessWidget {
  final Transaction transaction;
  final Function deleteTransaction;
  final Function editTransaction;
  final Function showTransactionInfo;

  TransactionCardTemplate({
    this.transaction,
    this.deleteTransaction,
    this.editTransaction,
    this.showTransactionInfo,
  });

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
              color: Theme.of(context).primaryColor,
            ),
          ),
          child: Text(
            '\$${transaction.price.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        title: Container(
          height: 27,
          child: FittedBox(
            alignment: Alignment.centerLeft,
            child: Text(
              transaction.title,
              style: Theme.of(context).textTheme.title,
            ),
          ),
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date),
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
                          onPressed: () => showTransactionInfo(
                            context,
                            transaction.title,
                            transaction.price,
                            transaction.date,
                            transaction.id,
                            editTransaction,
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
                            deleteTransaction(transaction.id);
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
                          onPressed: () => showTransactionInfo(
                            context,
                            transaction.title,
                            transaction.price,
                            transaction.date,
                            transaction.id,
                            editTransaction,
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
                            deleteTransaction(transaction.id);
                          },
                        ),
                      ),
                    ]),
        ),
      ),
    );
  }
}
