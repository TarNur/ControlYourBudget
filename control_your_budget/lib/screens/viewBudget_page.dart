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

  // AlamKategooria Listi Tile Loomine
  ListTile subCategoryListTile(
      double subCatAmount,
      double subCatLeft,
      String subCatName,
      String subCatNameInDB,
      int subCatID,
      String budgetCurrency) {
    String moneySpentAll = (subCatAmount - subCatLeft).toStringAsFixed(2);
    return ListTile(
      title: GestureDetector(
          child: Text(
            subCatName,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.cyan,
              fontSize: 20.0,
            ),
          ),
          onTap: () {
            print('open');
            _budgetHelper.getSingleSubCategoryBills(subCatID, subCatNameInDB);
            Navigator.of(context)
                .push(
              MaterialPageRoute(
                builder: (context) => ViewBills(
                  budgetID: subCatID,
                  budgetSubcategory: subCatNameInDB,
                  selectedCurrency: budgetCurrency,
                ),
              ),
            )
                .then((value) async {
              loadBudget();
              setState(() {});
            });
          }),
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
              _budgetHelper.getSingleSubCategoryBills(subCatID, subCatNameInDB);
              Navigator.of(context)
                  .push(
                MaterialPageRoute(
                  builder: (context) => ViewBills(
                    budgetID: subCatID,
                    budgetSubcategory: subCatNameInDB,
                    selectedCurrency: budgetCurrency,
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
        '  Money spent: $moneySpentAll of $subCatAmount $budgetCurrency',
        style: getColor(subCatLeft, subCatAmount),
      ),
    );
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
                    width: 15.0,
                  ),
                  Text(
                    'Name: $budgetName',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
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
                    String moneySpentAll = (snapshot.data.budgetAmount -
                            snapshot.data.budgetAmountLeft)
                        .toStringAsFixed(2);
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
                            '  Money spent: $moneySpentAll of ${snapshot.data.budgetAmount}${snapshot.data.selectedCurrency}',
                            style: getColor(snapshot.data.budgetAmountLeft,
                                snapshot.data.budgetAmount),
                          ),
                        ),
                        subCategoryListTile(
                            snapshot.data.transportBudget,
                            snapshot.data.transportBudgetLeft,
                            'Transport Budget',
                            'transportBudget',
                            snapshot.data.id,
                            snapshot.data.selectedCurrency),
                        SizedBox(
                          height: 2.0,
                        ),
                        subCategoryListTile(
                            snapshot.data.accomodationBudget,
                            snapshot.data.accomodationBudgetLeft,
                            'Accommodation Budget',
                            'accomodationBudget',
                            snapshot.data.id,
                            snapshot.data.selectedCurrency),
                        SizedBox(
                          height: 2.0,
                        ),
                        subCategoryListTile(
                            snapshot.data.foodBudget,
                            snapshot.data.foodBudgetLeft,
                            'Food Budget',
                            'foodBudget',
                            snapshot.data.id,
                            snapshot.data.selectedCurrency),
                        SizedBox(
                          height: 2.0,
                        ),
                        subCategoryListTile(
                            snapshot.data.pastimeBudget,
                            snapshot.data.pastimeBudgetLeft,
                            'Pastime Budget',
                            'pastimeBudget',
                            snapshot.data.id,
                            snapshot.data.selectedCurrency),
                        SizedBox(
                          height: 2.0,
                        ),
                        subCategoryListTile(
                            snapshot.data.otherExpensesBudget,
                            snapshot.data.otherExpensesBudgetLeft,
                            'Other Expenses',
                            'otherExpensesBudget',
                            snapshot.data.id,
                            snapshot.data.selectedCurrency),
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
