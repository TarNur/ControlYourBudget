import 'package:flutter/material.dart';
import 'package:control_your_budget/budget_helper.dart';
import 'package:control_your_budget/screens/viewBudget_page.dart';

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
      title: GestureDetector(
        child: Text(
          'View Budget: $budgetName', // TODO: Vaja lisada Nupp
          style: TextStyle(
            color: Colors.cyan,
            fontSize: 20.0,
          ),
        ),
        onTap: (){
          print('pressed view budget');
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => ViewBudgets(), // TODO: Nupp peab viima õige budgeti vaatele
            ),
          );
        },
      ),
      subtitle: Text(
        'Money left: $budgetAmount of $budgetAmount$selectedCurrency',
      ),
      trailing: Material(
        color: Colors.white,
        child: IconButton(
            icon: Icon(Icons.delete),
            iconSize: 25.0,
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
