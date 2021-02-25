import 'package:flutter/material.dart';

// Siia ühe Budgeti vaate page

class ViewBudgets extends StatefulWidget {
  @override
  _ViewBudgetsState createState() => _ViewBudgetsState();
}

class _ViewBudgetsState extends State<ViewBudgets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CONTROL YOUR BUDGET'),
      ),
      body: Text('hello'),
    );
  }
}