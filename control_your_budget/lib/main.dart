import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.cyan[100],
        appBar: AppBar(
          title: Text('ControlYourBudget'),
          backgroundColor: Colors.cyanAccent[700],
        ),
        body: Center(
          child: Image(
            image: AssetImage('images/CYBlogo.png'),
          ),
        ),
      ),
    ),
  );
}
