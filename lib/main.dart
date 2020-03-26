import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './widgets/chart.dart';
import './widgets/newTransaction.dart';
import './widgets/transactionCards.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spendings Planner',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.lightBlueAccent,
        fontFamily: 'Quicksand',
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.lightBlueAccent[100],
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
            subtitle: TextStyle(
              color: Colors.lightBlueAccent,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Quicksand',
            ),
            button: TextStyle(
                fontFamily: 'Quicksand', color: Colors.lightBlueAccent[100])),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _showCreateInputs(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  final List<Transaction> _transactionsMade = [];

  List<Transaction> get _weekTransactions {
    return _transactionsMade.where((transaction) {
      return transaction.date.isAfter(
        DateTime.now().subtract(
          Duration(
            days: 7,
          ),
        ),
      );
    }).toList();
  }

  bool _showChart = false;

  void _addTransaction(String title, double price, DateTime date) {
    final newTransaction = Transaction(
        title: title, price: price, date: date, id: '$title${date.toString()}');
    setState(() {
      _transactionsMade.add(newTransaction);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactionsMade.removeWhere((item) => item.id == id);
    });
  }

  void _editTransaction(String transactionId, TextEditingController newTitle,
      TextEditingController newPrice, DateTime newDate) {
    var _whereMatchId = _transactionsMade
        .where((transaction) => transaction.id == transactionId)
        .toList();
    setState(() {
      _whereMatchId[0].title = newTitle.text;
      _whereMatchId[0].price = double.parse(newPrice.text);
      _whereMatchId[0].date = newDate;
    });
//    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Spendings Planner'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  onTap: () => _showCreateInputs(context),
                  child: Icon(CupertinoIcons.add),
                )
              ],
            ),
          )
        : AppBar(
            title: Text('Spendings Planner'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add_shopping_cart),
                onPressed: () {
                  _showCreateInputs(context);
                },
              )
            ],
          );
    final cards = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionCards(
          _transactionsMade, _deleteTransaction, _editTransaction),
    );
    final homePage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Show Chart', style: Theme.of(context).textTheme.title,),
                  Switch.adaptive(
                    activeColor: Theme.of(context).accentColor,
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  ),
                ],
              ),
            if (isLandscape)
              _showChart
                  ? Container(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.6,
                      child: Chart(_weekTransactions),
                    )
                  : cards,
            if (!isLandscape)
              Column(
                children: <Widget>[
                  Container(
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.3,
                    child: Chart(_weekTransactions),
                  ),
                  cards,
                ],
              ),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: homePage,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: homePage,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? null
                : FloatingActionButton(
                    child: Icon(Icons.add_shopping_cart),
                    onPressed: () {
                      _showCreateInputs(context);
                    },
                  ),
          );
  }
}
