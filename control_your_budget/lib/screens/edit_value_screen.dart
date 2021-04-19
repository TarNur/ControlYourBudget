import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditValueScreen extends StatelessWidget {
  
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
              'Change Amount',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.cyan,
              ),
            ),
            TextField(
              autofocus: true,
              keyboardType: TextInputType.numberWithOptions(signed: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'^\d{0,5}[.]?\d?\d?'),
                ),
              ],
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
