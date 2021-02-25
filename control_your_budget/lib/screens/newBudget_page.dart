import 'package:flutter/material.dart';
import 'package:control_your_budget/constants.dart';
import 'package:control_your_budget/components/bottom_create_button.dart';
import 'package:flutter/services.dart';

class NewBudget extends StatefulWidget {
  @override
  _NewBudgetState createState() => _NewBudgetState();
}

class _NewBudgetState extends State<NewBudget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CONTROL YOUR BUDGET'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded( // BUDGET NAME SISESTUS
            flex: 1,
            child: Container(
              margin: EdgeInsets.all(15.0),
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: kInactiveCardColour,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextFormField(
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: 'Enter name for Budget',
                  labelText: 'Budget Name:',
                ),
                maxLength: 15,
                onFieldSubmitted: (text) {
                  print(text);
                },
              ),
            ),
          ),
          Expanded( // BUDGET AMOUNT SISESTUS
            flex: 1,
            child: Container(
              margin: EdgeInsets.all(15.0),
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: kInactiveCardColour,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextFormField( 
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d*.{1}\d*'), // sai vist Regexi tööle aga vaja kontrollida
                  ),
                ],
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: 'Enter Budget amount',
                  labelText: 'Budget:',
                ),
                maxLength: 15,
                onFieldSubmitted: (text) {
                  print(text);
                },
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              margin: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: kInactiveCardColour,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          BottomButton(
            onTap: () {
              print('Bottom button pushed.');
            },
            buttonTitle: 'CREATE BUDGET',
          )
        ],
      ),
    );
  }
}
