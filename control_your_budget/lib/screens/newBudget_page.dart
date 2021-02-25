import 'package:flutter/material.dart';
import 'package:control_your_budget/constants.dart';
import 'package:control_your_budget/components/bottom_create_button.dart';
import 'package:control_your_budget/components/new_budget_inputs.dart';

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
          Expanded(
            // BUDGET NAME SISESTUS
            flex: 1,
            child: BudgetNameInputField(),
          ),
          Expanded(
            // BUDGET AMOUNT SISESTUS
            flex: 1,
            child: FullBudgetAmountInputField(),
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
