import 'package:control_your_budget/models/budget.dart';
import 'package:flutter/material.dart';
import 'package:control_your_budget/constants.dart';
import 'package:control_your_budget/components/budgets_list.dart';
import 'package:control_your_budget/models/budget_data.dart';
import 'package:control_your_budget/budget_helper.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  BudgetHelper _budgetHelper = BudgetHelper();
  Future<List<BudgetInfo>> _budgets;

  @override
  void initState() {
    _budgetHelper.initializeDatabase().then((value) {
      print('-----------database initialized');
      _budgets = _budgetHelper.getBudgets();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.only(
                top: 60.0, left: 30.0, right: 30.0, bottom: 30.0),
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
                  '${BudgetData().budgets.length} Budgets Made',
                  style: TextStyle(
                    color: kLightGreyColour,
                    fontSize: 18,
                  ),
                ),
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
              child: BudgetsList(BudgetData().budgets),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        // Create New Budget Button
        onPressed: () {
          Navigator.pushNamed(context, '/first');
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.cyan,
      ),
    );
  }
}
