import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class AdaptiveFlatButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  AdaptiveFlatButton(this.text, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
      child: Text(
        'Choose Date',
        style: TextStyle(
            color: Theme.of(context).accentColor,
            fontWeight: FontWeight.bold),
      ),
      onPressed: onPressed,)
        : FlatButton(
      child: Text(
        'Choose Date',
        style: TextStyle(
            color: Theme.of(context).accentColor,
            fontWeight: FontWeight.bold),
      ),
      onPressed: onPressed,
    );
  }
}
