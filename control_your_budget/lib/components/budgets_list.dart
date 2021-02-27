import 'package:control_your_budget/models/budget.dart';
import 'package:flutter/material.dart';
import 'budget_tile.dart';
import 'package:control_your_budget/models/budget_data.dart';

class BudgetsList extends StatefulWidget {
  final List<BudgetInfo> budgets;

  BudgetsList(this.budgets);

  @override
  _BudgetsListState createState() => _BudgetsListState();
}

class _BudgetsListState extends State<BudgetsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return BudgetTile(
          budgetName: widget.budgets[index].budgetName,
          budgetAmount: widget.budgets[index].budgetAmount,
          selectedCurrency: widget.budgets[index].selectedCurrency,
        );
      },
      itemCount: widget.budgets.length,
    );
  }
}
