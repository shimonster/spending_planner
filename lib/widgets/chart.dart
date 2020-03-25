import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './chartBar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> weekTransactions;

  Chart(this.weekTransactions);

  List<Map<String, Object>> get dayTransactionInfo {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(
          days: index,
        ),
      );
      var totalSpent = 0.0;

      for (var i = 0; i < weekTransactions.length; i++) {
        if (weekTransactions[i].date.day == weekDay.day &&
            weekTransactions[i].date.month == weekDay.month &&
            weekTransactions[i].date.year == weekDay.year) {
          totalSpent += weekTransactions[i].price;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay),
        'amount': totalSpent,
      };
    }).reversed.toList();
  }



  double get weekSpending {
    return dayTransactionInfo.fold(0.0, (currentSum, currentItem) {
      double itemAmount = currentItem['amount'];
      return currentSum + itemAmount.abs();
    });
  }

  @override
  Widget build(BuildContext context) {
    print(dayTransactionInfo[0]['amount']);
    print(weekSpending);
    print((dayTransactionInfo[0]['amount'] as double) / weekSpending);
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(15),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: dayTransactionInfo.map((dayInfo) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                dayInfo['day'],
                dayInfo['amount'],
                weekSpending == 0
                    ? 0.0
                    : (dayInfo['amount'] as double) / weekSpending,
                weekSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
