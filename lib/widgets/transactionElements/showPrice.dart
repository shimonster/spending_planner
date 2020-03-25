import 'package:flutter/material.dart';


class ShowPrice extends StatelessWidget {
  final double transactionPrice;

  ShowPrice(this.transactionPrice);


  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 20,
      ),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColorDark,
          width: 2,
        ),
      ),
      child: Text(
        '\$${transactionPrice.toStringAsFixed(2)}',
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColorDark),
      ),
    );
  }
}
