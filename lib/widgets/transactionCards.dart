import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './transactionElements/transactionCardTemplate.dart';

import '../models/transaction.dart';
import './editTransaction.dart';

class TransactionCards extends StatelessWidget {
  final List<Transaction> transactionsMade;
  final Function deleteTransaction;
  final Function editTransaction;

  TransactionCards(
      this.transactionsMade, this.deleteTransaction, this.editTransaction);

  void _showTransactionInfo(BuildContext ctx, String title, double price,
      DateTime date, String id, Function editTransaction) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return EditTransaction(
              ctx, title, price, date, id, transactionsMade, editTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      child: transactionsMade.isEmpty
          ? LayoutBuilder(
              builder: (ctx, constraints) {
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
                        style: Theme.of(context).textTheme.title)
                  ],
                );
              },
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return TransactionCardTemplate(
                  transaction: transactionsMade[index],
                  deleteTransaction: deleteTransaction,
                  editTransaction: editTransaction,
                  showTransactionInfo: _showTransactionInfo,
                );
              },
              itemCount: transactionsMade.length,
            ),
    );
  }
}
