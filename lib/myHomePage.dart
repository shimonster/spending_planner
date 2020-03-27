import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './widgets/chart.dart';
import './widgets/newTransaction.dart';
import './widgets/transactionCards.dart';
import './models/transaction.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver{

  bool _showChart = false;
  final List<Transaction> _transactionsMade = [];

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

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


  void _addTransaction(String title, double price, DateTime date) {
    final newTransaction = Transaction(
        title: title, price: price, date: date, id: '$title$date');
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

  List<Widget> _buildLandscapeBody(
      MediaQueryData mediaQuery, AppBar appBar, cards, BuildContext context) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Show Chart',
            style: Theme.of(context).textTheme.title,
          ),
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
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.6,
              child: Chart(_weekTransactions),
            )
          : cards,
    ];
  }

  List<Widget> _buildPortraitBody(mediaQuery, appBar, cards) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3,
        child: Chart(_weekTransactions),
      ),
      cards,
    ];
  }

  Widget _buildAndroidAppBar (BuildContext context) {
    return AppBar(
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
  }

  Widget _buildIOSAppBar (BuildContext context) {
    return CupertinoNavigationBar(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? _buildIOSAppBar(context)
        : _buildAndroidAppBar(context);
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
            if (isLandscape) ..._buildLandscapeBody(mediaQuery, appBar, cards, context),
            if (!isLandscape) ..._buildPortraitBody(mediaQuery, appBar, cards),
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
