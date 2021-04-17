import 'package:control_your_budget/models/budget.dart';
import 'package:flutter/material.dart';
import 'package:control_your_budget/constants.dart';
import 'package:control_your_budget/components/bills_list.dart';
import 'package:control_your_budget/budget_helper.dart';
import 'package:control_your_budget/screens/newBudget_page.dart';

class ViewBills extends StatefulWidget {
  final int budgetID;
  final String budgetSubcategory;

  ViewBills({this.budgetID, this.budgetSubcategory});
  @override
  _ViewBillsState createState() => _ViewBillsState();
}

class _ViewBillsState extends State<ViewBills> {
  BudgetHelper _budgetHelper = BudgetHelper();
  Future<List<BillInfo>> _bills;
  var budgetsMade = 0;

  @override
  void initState() {
    _budgetHelper.initializeDatabase().then((value) {
      print('-----------database initialized');
      loadBills();
    });
    super.initState();
  }

  void loadBills() {
    _bills = _budgetHelper.getSingleSubCategoryBills(widget.budgetID, widget.budgetSubcategory);
    if (mounted) setState(() {});
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Your Bills:', // TODO: how many budgets made
                  style: TextStyle(
                    color: kLightGreyColour,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 10.0),
                FlatButton(
                  child: Text(
                    'Refresh Bills',
                    style: TextStyle(
                      color: Colors.cyan,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () {
                    print('loaded bills');
                    loadBills();
                  },
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
              child: FutureBuilder(
                  future: _bills,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return BillsList(snapshot.data);
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
    );
  }
}
