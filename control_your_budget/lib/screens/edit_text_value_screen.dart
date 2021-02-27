import 'package:flutter/material.dart';

class EditTextValueScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    String newValue;

    return Container(
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Change amount',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.cyan,
              ),
            ),
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                newValue = value;
              },
              onSubmitted: (value){
                newValue = value;
                Navigator.pop(context, newValue);
              },
            ),
            
          ],
        ),
      ),
    );
  }
}