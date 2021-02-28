import 'package:flutter/material.dart';
import 'package:control_your_budget/budget_helper.dart';

class BudgetTile extends StatelessWidget {
  final String budgetName;
  final double budgetAmount;
  final String selectedCurrency;
  final int id;

  BudgetTile(
      {this.id, this.budgetName, this.budgetAmount, this.selectedCurrency});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        'View Budget: $budgetName', // TODO: Vaja lisada Nupp
        style: TextStyle(
          color: Colors.cyan,
          fontSize: 20.0,
        ),
      ),
      subtitle: Text(
        '$budgetAmount $selectedCurrency',
      ),
      trailing: Material(
        color: Colors.white,
        child: IconButton(
            icon: Icon(Icons.delete),
            iconSize: 30.0,
            splashColor: Colors.redAccent,
            splashRadius: 40.0,
            color: Colors.red,
            onPressed: () {
              BudgetHelper().deleteBudget(id);
              print('deleted budget');
            }),
      ),
    );
  }
}
