// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

void main() => runApp(TipApp());

class TipApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tip-Calculator',
      home: TipCalc(),
    );
  }
}

class TipCalc extends StatefulWidget {
  @override
  _TipCalcState createState() => _TipCalcState();
}

class _TipCalcState extends State<TipCalc> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  double amt = 0;
  double tip = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tip-Calculator'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
                autofocus: true,
                decoration: const InputDecoration(
                  icon: const Icon(Icons.money_rounded),
                  hintText: 'Enter bill amount',
                  labelText: 'Bill Amount',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter valid bill amount';
                  }
                  return null;
                },
                onChanged: (value) {
                  amt = double.parse(value);
                }),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, display a Snackbar.
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Calculating Tip on $amt')));
                    _pushResults();
                  }
                },
                child: Text('Submit'))
          ],
        ),
      ),
    );
  }

  void _AlertDialog(context) {
    // Create button
    Widget okButton = ElevatedButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Results"),
      content: Text('Bill amount =  $amt \n'
          'Tip amount = $tip \n'
          'Total = ${amt + tip}'),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _pushResults() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Tip Calculated'),
            ),
            body: Form(
              key: _formKey2,
              child: Column(
                children: <Widget>[
                  TextFormField(
                      autofocus: true,
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.addchart),
                        hintText: 'Enter tip percentage',
                        labelText: 'Tip Percent',
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter valid percentage';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        tip = double.parse(value) * amt / 100;
                      }),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey2.currentState.validate()) {
                          // If the form is valid, display a Snackbar.
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text('Calculating Tip on $amt as $tip')));

                          _AlertDialog(context);
                        }
                      },
                      child: Text('Submit'))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
