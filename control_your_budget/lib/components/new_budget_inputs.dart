import 'package:flutter/material.dart';
import 'package:control_your_budget/constants.dart';
import 'package:flutter/services.dart';

class FullBudgetAmountInputField extends StatelessWidget {
  const FullBudgetAmountInputField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            RegExp(r'^\d*.{1}\d*'), // TODO: lubab läbi ühe tähe alguses
          ),
        ],
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          hintText: 'Enter Budget amount',
          labelText: 'Budget:',
        ),
        maxLength: 15,
        onFieldSubmitted: (text) {
          print(double.parse(text));
        },
      ),
    );
  }
}

class BudgetNameInputField extends StatelessWidget {
  const BudgetNameInputField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
