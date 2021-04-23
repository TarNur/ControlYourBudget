import 'package:control_your_budget/budget_helper.dart';
import 'package:control_your_budget/models/budget.dart';
import 'package:flutter/material.dart';
import 'package:control_your_budget/screens/newBill_page.dart';
import 'package:control_your_budget/screens/editBudget_page.dart';
import 'package:control_your_budget/components/sendEmail.dart';
import 'package:control_your_budget/screens/viewBills_page.dart';

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

  TextStyle getColor(double moneyLeft, double money) {
    if (moneyLeft / money < 0) {
      return TextStyle(
        fontSize: 12.0,
        color: Colors.red,
      );
    } else if (moneyLeft / money < 0.2) {
      return TextStyle(
        fontSize: 12.0,
        color: Colors.yellow[800],
      );
    } else {
      return TextStyle(
        fontSize: 12.0,
        color: Colors.green,
      );
    }
  }

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
                    return ListView(
                      children: [
                        ListTile(
                          title: Text(
                            'Budget Amount',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                            ),
                          ),
                          subtitle: Text(
                            '  Money spent: ${snapshot.data.budgetAmount - snapshot.data.budgetAmountLeft} of ${snapshot.data.budgetAmount}${snapshot.data.selectedCurrency}',
                            style: getColor(snapshot.data.budgetAmountLeft,
                                snapshot.data.budgetAmount),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Transport Budget',
                            style: TextStyle(
                              color: Colors.cyan,
                              fontSize: 20.0,
                            ),
                          ),
                          trailing: Material(
                            color: Colors.white,
                            child: IconButton(
                                icon: Icon(Icons.folder_open),
                                iconSize: 25.0,
                                splashColor: Colors.cyan,
                                splashRadius: 40.0,
                                color: Colors.cyan,
                                onPressed: () {
                                  print('open');
                                  _budgetHelper.getSingleSubCategoryBills(
                                      snapshot.data.id, 'transportBudget');
                                  Navigator.of(context)
                                      .push(
                                    MaterialPageRoute(
                                      builder: (context) => ViewBills(
                                        budgetID: snapshot.data.id,
                                        budgetSubcategory: 'transportBudget',
                                        selectedCurrency:
                                            snapshot.data.selectedCurrency,
                                      ),
                                    ),
                                  )
                                      .then((value) async {
                                    loadBudget();
                                    setState(() {});
                                  });
                                }),
                          ),
                          subtitle: Text(
                            '  Money spent: ${snapshot.data.transportBudget - snapshot.data.transportBudgetLeft} of ${snapshot.data.transportBudget}${snapshot.data.selectedCurrency}',
                            style: getColor(snapshot.data.transportBudgetLeft,
                                snapshot.data.transportBudget),
                          ),
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        ListTile(
                          title: Text(
                            'Accommodation Budget',
                            style: TextStyle(
                              color: Colors.cyan,
                              fontSize: 20.0,
                            ),
                          ),
                          subtitle: Text(
                            '  Money spent: ${snapshot.data.accomodationBudget - snapshot.data.accomodationBudgetLeft} of ${snapshot.data.accomodationBudget}${snapshot.data.selectedCurrency}',
                            style: getColor(
                                snapshot.data.accomodationBudgetLeft,
                                snapshot.data.accomodationBudget),
                          ),
                          trailing: Material(
                            color: Colors.white,
                            child: IconButton(
                                icon: Icon(Icons.folder_open),
                                iconSize: 25.0,
                                splashColor: Colors.cyan,
                                splashRadius: 40.0,
                                color: Colors.cyan,
                                onPressed: () {
                                  print('open');
                                  _budgetHelper.getSingleSubCategoryBills(
                                      snapshot.data.id, 'accomodationBudget');
                                  Navigator.of(context)
                                      .push(
                                    MaterialPageRoute(
                                      builder: (context) => ViewBills(
                                        budgetID: snapshot.data.id,
                                        budgetSubcategory: 'accomodationBudget',
                                        selectedCurrency:
                                            snapshot.data.selectedCurrency,
                                      ),
                                    ),
                                  )
                                      .then((value) async {
                                    loadBudget();
                                    setState(() {});
                                  });
                                }),
                          ),
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        ListTile(
                          title: Text(
                            'Food Budget',
                            style: TextStyle(
                              color: Colors.cyan,
                              fontSize: 20.0,
                            ),
                          ),
                          subtitle: Text(
                            '  Money spent: ${snapshot.data.foodBudget - snapshot.data.foodBudgetLeft} of ${snapshot.data.foodBudget}${snapshot.data.selectedCurrency}',
                            style: getColor(snapshot.data.foodBudgetLeft,
                                snapshot.data.foodBudget),
                          ),
                          trailing: Material(
                            color: Colors.white,
                            child: IconButton(
                                icon: Icon(Icons.folder_open),
                                iconSize: 25.0,
                                splashColor: Colors.cyan,
                                splashRadius: 40.0,
                                color: Colors.cyan,
                                onPressed: () {
                                  print('open');
                                  _budgetHelper.getSingleSubCategoryBills(
                                      snapshot.data.id, 'foodBudget');
                                  Navigator.of(context)
                                      .push(
                                    MaterialPageRoute(
                                      builder: (context) => ViewBills(
                                        budgetID: snapshot.data.id,
                                        budgetSubcategory: 'foodBudget',
                                        selectedCurrency:
                                            snapshot.data.selectedCurrency,
                                      ),
                                    ),
                                  )
                                      .then((value) async {
                                    loadBudget();
                                    setState(() {});
                                  });
                                }),
                          ),
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        ListTile(
                          title: Text(
                            'Pastime Budget',
                            style: TextStyle(
                              color: Colors.cyan,
                              fontSize: 20.0,
                            ),
                          ),
                          subtitle: Text(
                            '  Money spent: ${snapshot.data.pastimeBudget - snapshot.data.pastimeBudgetLeft} of ${snapshot.data.pastimeBudget}${snapshot.data.selectedCurrency}',
                            style: getColor(snapshot.data.pastimeBudgetLeft,
                                snapshot.data.pastimeBudget),
                          ),
                          trailing: Material(
                            color: Colors.white,
                            child: IconButton(
                                icon: Icon(Icons.folder_open),
                                iconSize: 25.0,
                                splashColor: Colors.cyan,
                                splashRadius: 40.0,
                                color: Colors.cyan,
                                onPressed: () {
                                  print('open');
                                  _budgetHelper.getSingleSubCategoryBills(
                                      snapshot.data.id, 'pastimeBudget');
                                  Navigator.of(context)
                                      .push(
                                    MaterialPageRoute(
                                      builder: (context) => ViewBills(
                                        budgetID: snapshot.data.id,
                                        budgetSubcategory: 'pastimeBudget',
                                        selectedCurrency:
                                            snapshot.data.selectedCurrency,
                                      ),
                                    ),
                                  )
                                      .then((value) async {
                                    loadBudget();
                                    setState(() {});
                                  });
                                }),
                          ),
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        ListTile(
                          title: Text(
                            'Other Expenses',
                            style: TextStyle(
                              color: Colors.cyan,
                              fontSize: 20.0,
                            ),
                          ),
                          subtitle: Text(
                            '  Money spent: ${snapshot.data.otherExpensesBudget - snapshot.data.otherExpensesBudgetLeft} of ${snapshot.data.otherExpensesBudget}${snapshot.data.selectedCurrency}',
                            style: getColor(
                                snapshot.data.otherExpensesBudgetLeft,
                                snapshot.data.otherExpensesBudget),
                          ),
                          trailing: Material(
                            color: Colors.white,
                            child: IconButton(
                                icon: Icon(Icons.folder_open),
                                iconSize: 25.0,
                                splashColor: Colors.cyan,
                                splashRadius: 40.0,
                                color: Colors.cyan,
                                onPressed: () {
                                  print('open');
                                  _budgetHelper.getSingleSubCategoryBills(
                                      snapshot.data.id, 'otherExpensesBudget');
                                  Navigator.of(context)
                                      .push(
                                    MaterialPageRoute(
                                      builder: (context) => ViewBills(
                                        budgetID: snapshot.data.id,
                                        budgetSubcategory:
                                            'otherExpensesBudget',
                                        selectedCurrency:
                                            snapshot.data.selectedCurrency,
                                      ),
                                    ),
                                  )
                                      .then((value) async {
                                    loadBudget();
                                    setState(() {});
                                  });
                                }),
                          ),
                        ),
                      ],
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
