import 'package:control_your_budget/models/budget.dart';
import 'package:flutter/material.dart';
import 'package:control_your_budget/constants.dart';
import 'package:control_your_budget/budget_helper.dart';
import 'package:control_your_budget/screens/editBill_page.dart';
import 'package:control_your_budget/screens/newBill_subCat_page.dart';

class ViewBills extends StatefulWidget {
  final int budgetID;
  final String budgetSubcategory;
  final String selectedCurrency;

  ViewBills({this.budgetID, this.budgetSubcategory, this.selectedCurrency});
  @override
  _ViewBillsState createState() => _ViewBillsState();
}

class _ViewBillsState extends State<ViewBills> {
  BudgetHelper _budgetHelper = BudgetHelper();
  BudgetInfo _budget;
  Future<List<BillInfo>> _bills;
  BudgetInfo budget;
  String reimb;

  double addToTransportBudget = 0;
  double addToAccomodationBudget = 0;
  double addToFoodBudget = 0;
  double addToPastimeBudget = 0;
  double addToOtherExpensesBudget = 0;
  var budgetsMade = 0;

  showAlertDialogDeleteBill(
      BuildContext context, int deleteBillID, BudgetInfo updatedBudget) {
    // set up the button
    Widget deleteButton = FlatButton(
      child: Text("Confirm"),
      onPressed: () {
        BudgetHelper().updateBudget(updatedBudget);
        BudgetHelper().deleteBill(deleteBillID);
        Navigator.of(context).pop();
        loadBills();
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
      title: Text('Are you sure you wanted to delete this bill?'),
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
    loadBudget();
    loadBills();
    super.initState();
  }

  void loadBudget() async {
    _budget = await _budgetHelper.getBudget(widget.budgetID);
  }

  void loadBills() {
    _bills = _budgetHelper.getSingleSubCategoryBillsWithoutImage(
        widget.budgetID, widget.budgetSubcategory);
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
                child: FutureBuilder(
                    future: _bills,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.length < 1) {
                          return Center(
                            child: Text(
                              'No bills made...',
                              style:
                                  TextStyle(color: Colors.cyan, fontSize: 30.0),
                            ),
                          );
                        }
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            String reimb =
                                snapshot.data[index].reimbursable == 0
                                    ? 'No'
                                    : 'Yes';
                            return ListTile(
                              title: GestureDetector(
                                child: Text(
                                  'Bill: ${snapshot.data[index].billName}',
                                  style: TextStyle(
                                    color: Colors.cyan,
                                    fontSize: 20.0,
                                  ),
                                ),
                                onTap: () async {
                                  BillInfo selectedBill = await _budgetHelper
                                      .getBill(snapshot.data[index].billID);
                                  print('pressed view bill');
                                  Navigator.of(context)
                                      .push(
                                    MaterialPageRoute(
                                      builder: (context) => EditBill(
                                          bill: selectedBill,
                                          selectedCurrency:
                                              widget.selectedCurrency),
                                    ),
                                  )
                                      .then((value) {
                                    loadBills();
                                    setState(() {});
                                  });
                                },
                              ),
                              subtitle: Text(
                                ' Amount: ${snapshot.data[index].billAmount}${widget.selectedCurrency}\n Reimbursable: $reimb\n Payed with ${snapshot.data[index].paymentType}\n Date: ${snapshot.data[index].date}',
                              ),
                              trailing: Material(
                                color: Colors.white,
                                child: IconButton(
                                    icon: Icon(Icons.delete),
                                    iconSize: 25.0,
                                    splashColor: Colors.redAccent,
                                    splashRadius: 40.0,
                                    color: Colors.red,
                                    onPressed: () async {
                                      budget = await BudgetHelper()
                                          .getBudget(widget.budgetID);
                                      if (widget.budgetSubcategory ==
                                          'transportBudget') {
                                        addToTransportBudget =
                                            snapshot.data[index].billAmount;
                                      } else if (widget.budgetSubcategory ==
                                          'accomodationBudget') {
                                        addToAccomodationBudget =
                                            snapshot.data[index].billAmount;
                                      } else if (widget.budgetSubcategory ==
                                          'foodBudget') {
                                        addToFoodBudget =
                                            snapshot.data[index].billAmount;
                                      } else if (widget.budgetSubcategory ==
                                          'pastimeBudget') {
                                        addToPastimeBudget =
                                            snapshot.data[index].billAmount;
                                      } else {
                                        addToOtherExpensesBudget =
                                            snapshot.data[index].billAmount;
                                      }
                                      var budgetInfo = BudgetInfo(
                                        id: budget.id,
                                        budgetName: budget.budgetName,
                                        budgetAmount: budget.budgetAmount,
                                        transportBudget: budget.transportBudget,
                                        accomodationBudget:
                                            budget.accomodationBudget,
                                        foodBudget: budget.foodBudget,
                                        pastimeBudget: budget.pastimeBudget,
                                        otherExpensesBudget:
                                            budget.otherExpensesBudget,
                                        selectedCurrency:
                                            budget.selectedCurrency,
                                        budgetAmountLeft:
                                            budget.budgetAmountLeft +
                                                snapshot.data[index].billAmount,
                                        transportBudgetLeft:
                                            budget.transportBudgetLeft +
                                                addToTransportBudget,
                                        accomodationBudgetLeft:
                                            budget.accomodationBudgetLeft +
                                                addToAccomodationBudget,
                                        foodBudgetLeft: budget.foodBudgetLeft +
                                            addToFoodBudget,
                                        pastimeBudgetLeft:
                                            budget.pastimeBudgetLeft +
                                                addToPastimeBudget,
                                        otherExpensesBudgetLeft:
                                            budget.otherExpensesBudgetLeft +
                                                addToOtherExpensesBudget,
                                      );
                                      showAlertDialogDeleteBill(
                                          context,
                                          snapshot.data[index].billID,
                                          budgetInfo);
                                      print('deleted');
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
                    })),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        // Create New Bill Button
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => NewBill(
                budgetID: widget.budgetID,
                budgetSubcategory: widget.budgetSubcategory,
                selectedCurrency: widget.selectedCurrency,
              ),
            ),
          )
              .then((value) {
            loadBills();
            setState(() {});
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.cyan,
      ),
    );
  }
}
