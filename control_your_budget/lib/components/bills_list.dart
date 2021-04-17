import 'package:control_your_budget/models/budget.dart';
import 'package:control_your_budget/budget_helper.dart';
import 'package:flutter/material.dart';

class BillsList extends StatefulWidget {
  final int budgetID;
  final String subCategory;

  BillsList({this.budgetID, this.subCategory});

  @override
  _BillsListState createState() => _BillsListState();
}

class _BillsListState extends State<BillsList> {
  BudgetHelper _budgetHelper = BudgetHelper();
  Future<List<BillInfo>> _bills;
  BudgetInfo budget;
  String reimb;
  @override
  void initState() {
    loadBills();
    super.initState();
  }

  void loadBills() {
    _bills = _budgetHelper.getSingleSubCategoryBills(
        widget.budgetID, widget.subCategory);
    if (mounted) setState(() {});
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _bills,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: GestureDetector(
                    child: Text(
                      'Bill: ${snapshot.data[index].billName}', // TODO: Vaja lisada Nupp
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
                    'Amount: ${snapshot.data[index].billAmount}, Reimbursable: ${snapshot.data[index].reimbursable}, Payed with ${snapshot.data[index].paymentType}',
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
                          budget =
                              await BudgetHelper().getBudget(widget.budgetID);
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
                            budgetAmountLeft: budget.budgetAmountLeft +
                                snapshot.data[index].billAmount,
                            transportBudgetLeft: budget.transportBudgetLeft +
                                snapshot.data[index].billAmount,
                            accomodationBudgetLeft:
                                budget.accomodationBudgetLeft,
                            foodBudgetLeft: budget.foodBudgetLeft,
                            pastimeBudgetLeft: budget.pastimeBudgetLeft,
                            otherExpensesBudgetLeft:
                                budget.otherExpensesBudgetLeft,
                          );
                          BudgetHelper().updateBudget(budgetInfo);
                          BudgetHelper()
                              .deleteBill(snapshot.data[index].billID);
                          loadBills();
                          print('deleteida veel ei saa');
                        }),
                  ),
                );
              },
              itemCount: snapshot.data.length,
            );
          }
          return Center(
            child: Text(
              'Loading...',
              style: TextStyle(color: Colors.cyan, fontSize: 30.0),
            ),
          );
        });
  }
}
