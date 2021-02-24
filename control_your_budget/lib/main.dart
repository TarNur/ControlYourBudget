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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(128.0),
                  child: Image.asset('images/CYBlogo.png'),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.cyanAccent[700],
         ),
         body: Budgetpage(),
      ),
    ),  
  );
}

class Budgetpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlatButton(
          onPressed: (){
            print('Top button pressed.');
          },
          child: Container(
            padding: EdgeInsets.all(10.0),
            color: Colors.white,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
            child: Row(
              children: [
                Icon(
                  Icons.note_add,
                  size: 20.0,
                  color: Colors.cyanAccent[700],
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  'Start new budget',
                  style: TextStyle(
                    color: Colors.cyanAccent[700],
                    fontSize: 20.0,
                  ),
                ),
              ]
            ),
          ),
        ),
        FlatButton(
          onPressed: (){
            print('Bottom button pressed.');
          },
          child: Container(
            padding: EdgeInsets.all(10.0),
            color: Colors.white,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
            child: Row(
              children: [
                Icon(
                  Icons.settings,
                  size: 20.0,
                  color: Colors.cyanAccent[700],
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  'Settings',
                  style: TextStyle(
                    color: Colors.cyanAccent[700],
                    fontSize: 20.0,
                  ),
                ),
              ]
            ),
          ),
        ),
      ],
    );
  }
}
