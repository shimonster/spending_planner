import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './myHomePage.dart';


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

