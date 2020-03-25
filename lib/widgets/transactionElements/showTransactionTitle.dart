import 'package:flutter/material.dart';


class ShowTransactionTitle extends StatelessWidget {
  final String transactionTitle;

  ShowTransactionTitle(this.transactionTitle);


  @override
  Widget build(BuildContext context) {
    return Text(
      transactionTitle,
      style: Theme.of(context).textTheme.title,
      textAlign: TextAlign.center,
    );
  }
}
