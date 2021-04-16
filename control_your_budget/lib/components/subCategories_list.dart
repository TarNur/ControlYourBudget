import 'package:control_your_budget/models/budget.dart';
import 'package:flutter/material.dart';

class BudgetsList extends StatefulWidget { //TODO: Nimi vaja muuta
  final BudgetInfo budgets;

  BudgetsList(this.budgets);

  @override
  _BudgetsListState createState() => _BudgetsListState();
}

class _BudgetsListState extends State<BudgetsList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: GestureDetector(
            child: Text(
              'Budget Amount', // TODO: Vaja lisada Nupp
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
              ),
            ),
            onTap: () {
              
            },
          ),
          subtitle: Text(
            'Money left: ${widget.budgets.budgetAmountLeft} of ${widget.budgets.budgetAmount}${widget.budgets.selectedCurrency}',
          ),
        ),
        ListTile(
          title: GestureDetector(
            child: Text(
              'Transport Budget', // TODO: Vaja lisada Nupp
              style: TextStyle(
                color: Colors.cyan,
                fontSize: 20.0,
              ),
            ),
            onTap: () {
              
            },
          ),
          subtitle: Text(
            'Money left: ${widget.budgets.transportBudgetLeft} of ${widget.budgets.transportBudget}${widget.budgets.selectedCurrency}',
          ),
        ),
        ListTile(
          title: GestureDetector(
            child: Text(
              'Accomodation Budget', // TODO: Vaja lisada Nupp
              style: TextStyle(
                color: Colors.cyan,
                fontSize: 20.0,
              ),
            ),
            onTap: () {
              
            },
          ),
          subtitle: Text(
            'Money left: ${widget.budgets.accomodationBudgetLeft} of ${widget.budgets.accomodationBudget}${widget.budgets.selectedCurrency}',
          ),
        ),
        ListTile(
          title: GestureDetector(
            child: Text(
              'Food Budget', // TODO: Vaja lisada Nupp
              style: TextStyle(
                color: Colors.cyan,
                fontSize: 20.0,
              ),
            ),
            onTap: () {
              
            },
          ),
          subtitle: Text(
            'Money left: ${widget.budgets.foodBudgetLeft} of ${widget.budgets.foodBudget}${widget.budgets.selectedCurrency}',
          ),
        ),
        ListTile(
          title: GestureDetector(
            child: Text(
              'Pastime Budget', // TODO: Vaja lisada Nupp
              style: TextStyle(
                color: Colors.cyan,
                fontSize: 20.0,
              ),
            ),
            onTap: () {
              
            },
          ),
          subtitle: Text(
            'Money left: ${widget.budgets.pastimeBudgetLeft} of ${widget.budgets.pastimeBudget}${widget.budgets.selectedCurrency}',
          ),
        ),
        ListTile(
          title: GestureDetector(
            child: Text(
              'Transport Budget', // TODO: Vaja lisada Nupp
              style: TextStyle(
                color: Colors.cyan,
                fontSize: 20.0,
              ),
            ),
            onTap: () {
              
            },
          ),
          subtitle: Text(
            'Money left: ${widget.budgets.otherExpensesBudgetLeft} of ${widget.budgets.otherExpensesBudget}${widget.budgets.selectedCurrency}',
          ),
        ),
      ],
    );
  }
}
