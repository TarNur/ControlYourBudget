import 'package:flutter/material.dart';
import 'package:control_your_budget/constants.dart';
import 'package:control_your_budget/models/budget.dart';
import 'package:control_your_budget/screens/viewBudget_page.dart';
import 'package:control_your_budget/budget_helper.dart';
import 'package:control_your_budget/screens/newBudget_page.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  BudgetHelper _budgetHelper = BudgetHelper();
  Future<List<BudgetInfo>> _budgets;

  int change = 0;

  showAlertDialogDeleteBudget(BuildContext context, int deleteBudgetID) {
    // set up the button
    Widget deleteButton = FlatButton(
      child: Text("Confirm"),
      onPressed: () {
        BudgetHelper().deleteAllBillsFromBudget(deleteBudgetID);
        BudgetHelper().deleteBudget(deleteBudgetID);
        Navigator.of(context).pop();
        loadBudgets();
      },
    );

    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text('Are you sure you wanted to delete this budget?'),
      content: Text('All of its bills will also be deleted.'),
      actions: [
        cancelButton,
        deleteButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    loadBudgets();
    super.initState();
  }

  void loadBudgets() {
    _budgets = _budgetHelper.getBudgets();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.only(
                top: 60.0, left: 30.0, right: 30.0, bottom: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                CircleAvatar(
                  child: Icon(
                    Icons.credit_card,
                    size: 30.0,
                    color: Colors.cyan,
                  ),
                  backgroundColor: Colors.white,
                  radius: 30.0,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Control Your Budget',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Your Budgets:',
                  style: TextStyle(
                    color: kLightGreyColour,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 10.0),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: FutureBuilder(
                  future: _budgets,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.length < 1) {
                        return Center(
                          child: Text(
                            'No budgets made...',
                            style:
                                TextStyle(color: Colors.cyan, fontSize: 30.0),
                          ),
                        );
                      }
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          String moneySpent =
                              (snapshot.data[index].budgetAmount -
                                      snapshot.data[index].budgetAmountLeft)
                                  .toStringAsFixed(2);
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
                                      budgetName:
                                          snapshot.data[index].budgetName,
                                      budgetAmount:
                                          snapshot.data[index].budgetAmount,
                                      budgetAmountLeft:
                                          snapshot.data[index].budgetAmountLeft,
                                      budgetID: snapshot.data[index].id,
                                      selectedCurrency:
                                          snapshot.data[index].selectedCurrency,
                                    ),
                                  ),
                                )
                                    .then((value) {
                                  loadBudgets();
                                  setState(() {});
                                });
                              },
                            ),
                            subtitle: Text(
                              'Money spent: $moneySpent of ${snapshot.data[index].budgetAmount}${snapshot.data[index].selectedCurrency}',
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
                                    showAlertDialogDeleteBudget(
                                        context, snapshot.data[index].id);
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
                  }),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        // Create New Budget Button
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => NewBudget(),
            ),
          )
              .then((value) {
            loadBudgets();
            setState(() {});
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.cyan,
      ),
    );
  }
}
