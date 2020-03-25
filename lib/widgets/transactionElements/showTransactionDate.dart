import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class ShowTransactionDate extends StatelessWidget {
  final DateTime transactionDate;

  ShowTransactionDate(this.transactionDate);

  @override
  Widget build(BuildContext context) {
    return Text(
      DateFormat('yMMMd').format(transactionDate),
      style: TextStyle(fontSize: 15, color: Colors.grey),
    );
  }
}
