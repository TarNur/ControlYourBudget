import 'package:control_your_budget/models/budget.dart';
import 'package:control_your_budget/budget_helper.dart';
import 'package:control_your_budget/screens/start_page.dart';
import 'package:flutter/material.dart';
import 'package:control_your_budget/screens/viewBudget_page.dart';

class BudgetsList extends StatefulWidget {
  final int change;
  BudgetsList(this.change);
  @override
  _BudgetsListState createState() => _BudgetsListState();
}

class _BudgetsListState extends State<BudgetsList> {
  BudgetHelper _budgetHelper = BudgetHelper();
  Future<List<BudgetInfo>> _budgets;

  @override
  void initState() {
    loadBudgets();
    super.initState();
  }

  void loadBudgets() async {
    _budgets = _budgetHelper.getBudgets();
    if (mounted) setState(() {});
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _budgets,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: GestureDetector(
                    child: Text(
                      'View Budget: ${snapshot.data[index].budgetName}',
                      style: TextStyle(
                        color: Colors.cyan,
                        fontSize: 20.0,
                      ),
                    ),
                    onTap: () {
                      print('pressed view budget');
                      Navigator.of(context)
                          .push(
                        MaterialPageRoute(
                          builder: (context) => ViewBudgets(
                            budgetName: snapshot.data[index].budgetName,
                            budgetAmount: snapshot.data[index].budgetAmount,
                            budgetAmountLeft:
                                snapshot.data[index].budgetAmountLeft,
                            budgetID: snapshot.data[index].id,
                            selectedCurrency:
                                snapshot.data[index].selectedCurrency,
                          ), 
                        ),
                      )
                          .then((value) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StartPage(),
                          ),
                        );
                      });
                    },
                  ),
                  subtitle: Text(
                    'Money left: ${snapshot.data[index].budgetAmountLeft} of ${snapshot.data[index].budgetAmount}${snapshot.data[index].selectedCurrency}',
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
                          BudgetHelper().deleteBudget(snapshot.data[index].id);
                          print('deleted budget');
                          loadBudgets();
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
