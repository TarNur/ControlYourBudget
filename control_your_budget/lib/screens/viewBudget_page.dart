import 'package:control_your_budget/budget_helper.dart';
import 'package:control_your_budget/models/budget.dart';
import 'package:flutter/material.dart';
import 'package:control_your_budget/screens/newBill_page.dart';
import 'package:control_your_budget/screens/editBudget_page.dart';
import 'package:control_your_budget/components/subCategories_list.dart';
import 'package:control_your_budget/components/sendEmail.dart';
import 'package:control_your_budget/screens/start_page.dart';

// Siia ühe Budgeti vaate page

class ViewBudgets extends StatefulWidget {
  final String budgetName;
  final double budgetAmount;
  final double budgetAmountLeft;
  final int budgetID;
  final String selectedCurrency;

  ViewBudgets(
      {this.budgetName,
      this.budgetAmount,
      this.budgetAmountLeft,
      this.budgetID,
      this.selectedCurrency});
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
  bool once = false;

  @override
  void initState() {
    loadBudget();
    super.initState();
  }

  void loadBudget() {
    _budget = _budgetHelper.getBudget(widget.budgetID);
    if (mounted) setState(() {});
  }

  Widget build(BuildContext context) {
    if (once == false) {
      budgetName = widget.budgetName;
      budgetAmount = widget.budgetAmount;
      budgetAmountLeft = widget.budgetAmountLeft;
      budgetID = widget.budgetID;
      selectedCurrency = widget.selectedCurrency;
    }
    once = true;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            iconSize: 25.0,
            color: Colors.cyan,
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => StartPage(),
                ),
              );
            }),
        title: Text('CONTROL YOUR BUDGET'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.attach_email,
              color: Colors.cyan,
            ),
            tooltip: 'Show Snackbar',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EmailSender(budgetID: widget.budgetID),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 20.0,
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
                    width: 10.0,
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    iconSize: 30.0,
                    color: Colors.cyan,
                    onPressed: () async {
                      BudgetInfo budget =
                          await _budgetHelper.getBudget(widget.budgetID);
                      Navigator.of(context)
                          .push(
                        MaterialPageRoute(
                          builder: (context) => EditBudget(
                            budget: budget,
                          ),
                        ),
                      )
                          .then((value) async {
                        budget = await _budgetHelper.getBudget(widget.budgetID);
                        budgetName = budget.budgetName;
                        loadBudget();
                        setState(() {});
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
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
        // Create New Bill Button
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => NewBill(
                budgetID: budgetID,
                selectedCurrency: selectedCurrency,
              ),
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
