import 'package:flutter/material.dart';

import './newTransaction.dart';
import './transactionCards.dart';
import '../models/transaction.dart';

class TransactionThings extends StatelessWidget {
  final Function addTransaction;
  final List<Transaction> transactionsMade;

  TransactionThings(this.addTransaction, this.transactionsMade);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(addTransaction),
      ],
    );
  }
}
