import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.cyan[100],
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Control Your Budget'),
            ],
          ),
          backgroundColor: Colors.cyanAccent[700],
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Budgetpage(),),
        ),
      ),
    ),
  );
}

class Budgetpage extends StatefulWidget {
  @override
  _BudgetpageState createState() => _BudgetpageState();
}

class _BudgetpageState extends State<Budgetpage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: FlatButton(
            onPressed: () {
              print('Full budget pressed.');
            },
            child: Container(
              child: Text('Your Full Budget'),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: FlatButton(
            onPressed: () {
              print('Transport budget pressed.');
            },
            child: Container(
              child: Text('Your Transport Budget'),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: FlatButton(
            onPressed: () {
              print('Food budget pressed.');
            },
            child: Container(
              child: Text('Your Food Budget'),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: FlatButton(
            onPressed: () {
              print('Accomodation budget pressed.');
            },
            child: Container(
              child: Text('Your Accomodation Budget'),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: FlatButton(
            onPressed: () {
              print('Pastime budget pressed.');
            },
            child: Container(
              child: Text('Your Pastime Budget'),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: FlatButton(
            onPressed: () {
              print('Other expenses pressed.');
            },
            child: Container(
              child: Text('Other expenses'),
            ),
          ),
        ),
      ],
    );
  }
}

