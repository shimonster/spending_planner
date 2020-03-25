import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String day;
  final double amountSpent;
  final double percentOfTotalSpent;
  final double weekAmount;

  ChartBar(this.day, this.amountSpent, this.percentOfTotalSpent, this.weekAmount);

  @override
  Widget build(BuildContext context) {
    print('$percentOfTotalSpent $day');
    return Column(children: <Widget>[
      Container(
        height: 20,
        child: FittedBox(
          child: Text('\$${amountSpent.toStringAsFixed(0)}'),
        ),
      ),
      SizedBox(
        height: 5,
      ),
      Container(
        child: Stack(
          children: <Widget>[
            Container(
              height: 60,
              width: 13,
              decoration: BoxDecoration(
                color: Color.fromRGBO(220, 220, 220, 1),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(7.5),
              ),
            ),
            percentOfTotalSpent >= 0 ?
            Container(
              width: 13,
              height: 60,
              alignment: Alignment.topCenter,
              child: FractionallySizedBox(
                heightFactor: percentOfTotalSpent > 1? percentOfTotalSpent/-weekAmount : percentOfTotalSpent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(7.5),
                  ),
                ),
              ),
            ) :
            Container(
              width: 13,
              height: 60,
              alignment: Alignment.bottomCenter,
              child: FractionallySizedBox(
                heightFactor: percentOfTotalSpent < -1? percentOfTotalSpent/weekAmount : -percentOfTotalSpent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(7.5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 5,
      ),
      Text(
        day,
      ),
    ]);
  }
}
