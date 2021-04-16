import 'package:control_your_budget/models/budget.dart';
import 'package:flutter/material.dart';

class BudgetsList extends StatefulWidget {
  //TODO: Nimi vaja muuta
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
          title: Text(
            'Budget Amount', 
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
            ),
          ),
          subtitle: Text(
            'Money left: ${widget.budgets.budgetAmountLeft} of ${widget.budgets.budgetAmount}${widget.budgets.selectedCurrency}',
          ),
        ),
        ListTile(
          title: Text(
            'Transport Budget', 
            style: TextStyle(
              color: Colors.cyan,
              fontSize: 20.0,
            ),
          ),
          trailing: Material(
            color: Colors.white,
            child: IconButton(
                icon: Icon(Icons.folder_open),
                iconSize: 25.0,
                splashColor: Colors.cyan,
                splashRadius: 40.0,
                color: Colors.cyan,
                onPressed: () {
                  print('open');
                }),
          ),
          subtitle: Text(
            'Money left: ${widget.budgets.transportBudgetLeft} of ${widget.budgets.transportBudget}${widget.budgets.selectedCurrency}',
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        ListTile(
          title: Text(
            'Accomodation Budget', 
            style: TextStyle(
              color: Colors.cyan,
              fontSize: 20.0,
            ),
          ),
          subtitle: Text(
            'Money left: ${widget.budgets.accomodationBudgetLeft} of ${widget.budgets.accomodationBudget}${widget.budgets.selectedCurrency}',
          ),
          trailing: Material(
            color: Colors.white,
            child: IconButton(
                icon: Icon(Icons.folder_open),
                iconSize: 25.0,
                splashColor: Colors.cyan,
                splashRadius: 40.0,
                color: Colors.cyan,
                onPressed: () {
                  print('open');
                }),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        ListTile(
          title: Text(
            'Food Budget', 
            style: TextStyle(
              color: Colors.cyan,
              fontSize: 20.0,
            ),
          ),
          subtitle: Text(
            'Money left: ${widget.budgets.foodBudgetLeft} of ${widget.budgets.foodBudget}${widget.budgets.selectedCurrency}',
          ),
          trailing: Material(
            color: Colors.white,
            child: IconButton(
                icon: Icon(Icons.folder_open),
                iconSize: 25.0,
                splashColor: Colors.cyan,
                splashRadius: 40.0,
                color: Colors.cyan,
                onPressed: () {
                  print('open');
                }),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        ListTile(
          title: Text(
            'Pastime Budget', 
            style: TextStyle(
              color: Colors.cyan,
              fontSize: 20.0,
            ),
          ),
          subtitle: Text(
            'Money left: ${widget.budgets.pastimeBudgetLeft} of ${widget.budgets.pastimeBudget}${widget.budgets.selectedCurrency}',
          ),
          trailing: Material(
            color: Colors.white,
            child: IconButton(
                icon: Icon(Icons.folder_open),
                iconSize: 25.0,
                splashColor: Colors.cyan,
                splashRadius: 40.0,
                color: Colors.cyan,
                onPressed: () {
                  print('open');
                }),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        ListTile(
          title: Text(
            'Other Expenses', 
            style: TextStyle(
              color: Colors.cyan,
              fontSize: 20.0,
            ),
          ),
          subtitle: Text(
            'Money left: ${widget.budgets.otherExpensesBudgetLeft} of ${widget.budgets.otherExpensesBudget}${widget.budgets.selectedCurrency}',
          ),
          trailing: Material(
            color: Colors.white,
            child: IconButton(
                icon: Icon(Icons.folder_open),
                iconSize: 25.0,
                splashColor: Colors.cyan,
                splashRadius: 40.0,
                color: Colors.cyan,
                onPressed: () {
                  print('open');
                }),
          ),
        ),
      ],
    );
  }
}
