import 'package:control_your_budget/components/alert_box.dart';
import 'package:flutter/material.dart';
import 'package:control_your_budget/constants.dart';
import 'package:control_your_budget/components/budgets_list.dart';
import 'package:control_your_budget/budget_helper.dart';
import 'package:control_your_budget/screens/newBudget_page.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  BudgetHelper _budgetHelper = BudgetHelper();
  int change = 0;

  @override
  void initState() {
    
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
              child: BudgetsList(change),
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
            change++;
            setState(() {});
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.cyan,
      ),
    );
  }
}
