import 'package:flutter/material.dart';
import 'package:control_your_budget/constants.dart';
import 'package:control_your_budget/components/bills_list.dart';
import 'package:control_your_budget/budget_helper.dart';

class ViewBills extends StatefulWidget {
  final int budgetID;
  final String budgetSubcategory;

  ViewBills({this.budgetID, this.budgetSubcategory});
  @override
  _ViewBillsState createState() => _ViewBillsState();
}

class _ViewBillsState extends State<ViewBills> {
  BudgetHelper _budgetHelper = BudgetHelper();
  var budgetsMade = 0;

  @override
  void initState() {
    _budgetHelper.initializeDatabase().then((value) {
      print('-----------database initialized');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CONTROL YOUR BUDGET'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
                top: 20.0, left: 30.0, right: 30.0, bottom: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(width: 10.0),
                Text(
                  'Your Bills: ',
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
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: BillsList(
                  budgetID: widget.budgetID,
                  subCategory: widget.budgetSubcategory),
            ),
          ),
        ],
      ),
    );
  }
}
