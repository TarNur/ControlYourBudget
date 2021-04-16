import 'package:control_your_budget/budget_helper.dart';
import 'package:control_your_budget/models/budget.dart';
import 'package:flutter/material.dart';
import 'package:control_your_budget/constants.dart';
import 'package:control_your_budget/screens/newBill_page.dart';
import 'package:control_your_budget/components/subCategories_list.dart';

// Siia ühe Budgeti vaate page
// TODO: KUHUGI VAJA BUDGETI EDITIMISE NUPP

class ViewBudgets extends StatefulWidget {
  final String budgetName;
  final double budgetAmount;
  final double budgetAmountLeft;
  final int budgetID;
  final String selectedCurrency;

  ViewBudgets({this.budgetName, this.budgetAmount, this.budgetAmountLeft, this.budgetID, this.selectedCurrency});
  @override
  _ViewBudgetsState createState() => _ViewBudgetsState();
}

class _ViewBudgetsState extends State<ViewBudgets> {
  BudgetHelper _budgetHelper = BudgetHelper();
  Future<BudgetInfo> _budget;
  String budgetName;
  double budgetAmount;
  double budgetAmountLeft;
  int budgetID;
  String selectedCurrency;

  @override
  void initState() {
    _budgetHelper.initializeDatabase().then((value) {
      print('-----------database initialized');
      loadBudget();
    });
    super.initState();
  }

  void loadBudget() {
    _budget = _budgetHelper.getBudget(budgetID);
    if (mounted) setState(() {});
  }

  Widget build(BuildContext context) {
    budgetName = widget.budgetName;
    budgetAmount = widget.budgetAmount;
    budgetAmountLeft = widget.budgetAmountLeft;
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
              Row(
                children: [
                  SizedBox(
                width: 30.0,
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
                width: 30.0,
              ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    iconSize: 30.0,
                    color: Colors.cyan,
                    onPressed: () {
                      
                    },
                  ),
                ],
              ),
              
            ],
          ),
        ),
        Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: FutureBuilder(
                  future: _budget,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return BudgetsList(snapshot.data);
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

      ]),
      floatingActionButton: FloatingActionButton(
        // Create New Budget Button
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => NewBill(budgetID: budgetID, selectedCurrency: selectedCurrency,),
            ),
          )
              .then((value) {
            loadBudget();
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.cyan,
      ),
    );
  }
}
