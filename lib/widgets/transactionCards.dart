import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './transactionElements/showPrice.dart';
import './transactionElements/showTransactionTitle.dart';
import './transactionElements/showTransactionDate.dart';
import '../models/transaction.dart';
import './editTransaction.dart';

class TransactionCards extends StatelessWidget {
  final List<Transaction> transactionsMade;
  final Function deleteTransaction;
  final Function editTransaction;

  TransactionCards(this.transactionsMade, this.deleteTransaction,
      this.editTransaction);

  void _showTransactionInfo(BuildContext ctx, String title, double price,
      DateTime date, String id, Function editTransaction) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return EditTransaction(
              ctx,
              title,
              price,
              date,
              id,
              transactionsMade,
              editTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactionsMade.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
        return Column(
          children: <Widget>[
            Container(
              height: constraints.maxHeight * 0.6,
              child: Image.asset(
                'assets/images/source.gif',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text('No Transactions',
                style: Theme
                    .of(context)
                    .textTheme
                    .title)
          ],
        );
      },)
          : ListView.builder(
        itemBuilder: (ctx, index) {
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
                    color: Theme
                        .of(context)
                        .primaryColor,
                  ),
                ),
                child: Text(
                  '\$${transactionsMade[index].price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme
                        .of(context)
                        .primaryColor,
                  ),
                ),
              ),
              title: Container(
                height: 27,
                child: FittedBox(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    transactionsMade[index].title,
                    style: Theme
                        .of(context)
                        .textTheme
                        .title,
                  ),
                ),
              ),
              subtitle: Text(
                DateFormat.yMMMd().format(transactionsMade[index].date),
              ),
              trailing: FittedBox(
                child: Row(
                  children: <Widget>[
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
                        onPressed: () =>
                            _showTransactionInfo(
                              context,
                              transactionsMade[index].title,
                              transactionsMade[index].price,
                              transactionsMade[index].date,
                              transactionsMade[index].id,
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
                            color: Theme
                                .of(context)
                                .errorColor,
                            width: 3,
                          ),
                          borderRadius:
                          BorderRadius.all(Radius.circular(40))),
                      child: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Theme
                              .of(context)
                              .errorColor,
                        ),
                        onPressed: () {
                          deleteTransaction(transactionsMade[index].id);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: transactionsMade.length,
      ),
    );
  }
}
