import 'package:control_your_budget/budget_helper.dart';
import 'package:flutter/material.dart';
import 'package:control_your_budget/constants.dart';
import 'package:control_your_budget/screens/newBill_page.dart';

// Siia ühe Budgeti vaate page

class ViewBudgets extends StatefulWidget {
  final String budgetName;
  final double budgetAmount;
  final int budgetID;
  final String selectedCurrency;

  ViewBudgets({this.budgetName, this.budgetAmount, this.budgetID, this.selectedCurrency});
  @override
  _ViewBudgetsState createState() => _ViewBudgetsState();
}

class _ViewBudgetsState extends State<ViewBudgets> {
  String budgetName;
  double budgetAmount;
  int budgetID;
  String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    budgetName = widget.budgetName;
    budgetAmount = widget.budgetAmount;
    budgetID = widget.budgetID;
    selectedCurrency = widget.selectedCurrency;
    return Scaffold(
      appBar: AppBar(
        title: Text('CONTROL YOUR BUDGET'),
      ),
      body: Column(children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Budget name: $budgetName',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Budget amount: $budgetAmount left of $budgetAmount$selectedCurrency', // TODO: how many budgets made
                style: TextStyle(
                  color: kLightGreyColour,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
        Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 70.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Center(child: Text('Alamkategooriad koos arvetega siia...'))
            ),
          ),

      ]),
      floatingActionButton: FloatingActionButton(
        // Create New Budget Button
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => NewBill(),
            ),
          )
              .then((value) {
            //loadBudgets();
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.cyan,
      ),
    );
  }
}
