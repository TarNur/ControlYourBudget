import 'package:flutter/material.dart';
import 'package:control_your_budget/budget_helper.dart';
import 'package:control_your_budget/models/budget.dart';

class BillTile extends StatelessWidget {
  final int id;
  final int billID;
  final String billName;
  final double billAmount;
  final String billSubcategory;
  final String paymentType;
  final int reimbursable;

  BillTile(
      {this.id,
      this.billID,
      this.billName,
      this.billAmount,
      this.billSubcategory,
      this.paymentType,
      this.reimbursable});

  @override
  Widget build(BuildContext context) {
    String reimb = reimbursable == 0 ? 'No' : 'Yes';
    BudgetInfo budget;
    return ListTile(
      title: GestureDetector(
        child: Text(
          'Bill: $billName', 
          style: TextStyle(
            color: Colors.cyan,
            fontSize: 20.0,
          ),
        ),
        onTap: () {
          print('pressed view budget');
        },
      ),
      subtitle: Text(
        'Amount: $billAmount, Reimbursable: $reimb, Payed with $paymentType',
      ),
      trailing: Material(
        color: Colors.white,
        child: IconButton(
            icon: Icon(Icons.delete),
            iconSize: 25.0,
            splashColor: Colors.redAccent,
            splashRadius: 40.0,
            color: Colors.red,
            onPressed: () async {
              budget = await BudgetHelper().getBudget(id);
              var budgetInfo = BudgetInfo(
                id: budget.id,
                budgetName: budget.budgetName,
                budgetAmount: budget.budgetAmount,
                transportBudget: budget.transportBudget,
                accomodationBudget: budget.accomodationBudget,
                foodBudget: budget.foodBudget,
                pastimeBudget: budget.pastimeBudget,
                otherExpensesBudget: budget.otherExpensesBudget,
                selectedCurrency: budget.selectedCurrency,
                budgetAmountLeft: budget.budgetAmountLeft + billAmount,
                transportBudgetLeft: budget.transportBudgetLeft + billAmount,
                accomodationBudgetLeft: budget.accomodationBudgetLeft,
                foodBudgetLeft: budget.foodBudgetLeft,
                pastimeBudgetLeft: budget.pastimeBudgetLeft,
                otherExpensesBudgetLeft: budget.otherExpensesBudgetLeft,
              );
              BudgetHelper().updateBudget(budgetInfo);
              BudgetHelper().deleteBill(billID);

              print('deleteida veel ei saa');
            }),
      ),
    );
  }
}
