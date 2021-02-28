import 'package:control_your_budget/budget_helper.dart';
import 'package:control_your_budget/models/budget.dart';
import 'package:flutter/material.dart';
import 'package:control_your_budget/constants.dart';
import 'package:control_your_budget/components/bottom_create_button.dart';
import 'package:control_your_budget/screens/edit_value_screen.dart';
import 'package:control_your_budget/screens/edit_text_value_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:control_your_budget/components/alert_box.dart';
import 'dart:io' show Platform;

class NewBudget extends StatefulWidget {
  @override
  _NewBudgetState createState() => _NewBudgetState();
}

class _NewBudgetState extends State<NewBudget> {
  BudgetHelper _budgetHelper = BudgetHelper();

  String budgetName = 'Enter Budget Name';
  double budgetAmount = 0;
  double moneyLeft = 0;
  double transportBudget = 0;
  double foodBudget = 0;
  double accomodationBudget = 0;
  double pastimeBudget = 0;
  double otherExpensesBudget = 0;
  String selectedCurrency = 'EUR';
  bool ifBudgetNameChanged = false;

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.cyan,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
        });
      },
      children: pickerItems,
    );
  }

  @override
  void initState() {
    _budgetHelper.initializeDatabase().then((value) {
      print('-----------database initialized');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    moneyLeft = budgetAmount -
        transportBudget -
        foodBudget -
        accomodationBudget -
        pastimeBudget -
        otherExpensesBudget;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('CONTROL YOUR BUDGET'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // BUDGET NAME SISESTUS
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Budget Name: $budgetName',
                    style: kLabelTextStyle,
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    iconSize: 30.0,
                    color: Colors.cyan,
                    onPressed: () async {
                      var typedValue = await showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: EditTextValueScreen(),
                          ),
                        ),
                      );
                      if (typedValue != null) {
                        setState(() {
                          budgetName = typedValue;
                          ifBudgetNameChanged = true;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          // BUDGET AMOUNT SISESTUS
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Budget Amount: $budgetAmount $selectedCurrency',
                    style: kLabelTextStyle,
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    iconSize: 30.0,
                    color: Colors.cyan,
                    onPressed: () async {
                      var typedValue = await showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: EditValueScreen(),
                          ),
                        ),
                      );
                      if (typedValue != null) {
                        setState(() {
                          budgetAmount = double.parse(typedValue);
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 55.0,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            color: Colors.cyan,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
          Expanded(
            flex: 4,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              // ALAMKATEGOORIAD
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // TRANSPORT BUDGET
                    children: [
                      Text(
                        'Transport Budget: $transportBudget $selectedCurrency',
                        style: kLabelTextStyle,
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        iconSize: 30.0,
                        color: Colors.cyan,
                        onPressed: () async {
                          var typedValue = await showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: EditValueScreen(),
                              ),
                            ),
                          );
                          if (typedValue != null) {
                            setState(() {
                              transportBudget = double.parse(typedValue);
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // ACCOMODATION BUDGET
                    children: [
                      Text(
                        'Accomodation budget: $accomodationBudget $selectedCurrency',
                        style: kLabelTextStyle,
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        iconSize: 30.0,
                        color: Colors.cyan,
                        onPressed: () async {
                          var typedValue = await showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: EditValueScreen(),
                              ),
                            ),
                          );
                          if (typedValue != null) {
                            setState(() {
                              accomodationBudget = double.parse(typedValue);
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // FOOD BUDGET
                    children: [
                      Text(
                        'Food Budget: $foodBudget $selectedCurrency',
                        style: kLabelTextStyle,
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        iconSize: 30.0,
                        color: Colors.cyan,
                        onPressed: () async {
                          var typedValue = await showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: EditValueScreen(),
                              ),
                            ),
                          );
                          if (typedValue != null) {
                            setState(() {
                              foodBudget = double.parse(typedValue);
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // PASTIME BUDGET
                    children: [
                      Text(
                        'Pastime Budget: $pastimeBudget $selectedCurrency',
                        style: kLabelTextStyle,
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        iconSize: 30.0,
                        color: Colors.cyan,
                        onPressed: () async {
                          var typedValue = await showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: EditValueScreen(),
                              ),
                            ),
                          );
                          if (typedValue != null) {
                            setState(() {
                              pastimeBudget = double.parse(typedValue);
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // OTHER EXPENSES BUDGET
                    children: [
                      Text(
                        'Other Expenses: $otherExpensesBudget $selectedCurrency',
                        style: kLabelTextStyle,
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        iconSize: 30.0,
                        color: Colors.cyan,
                        onPressed: () async {
                          var typedValue = await showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: EditValueScreen(),
                              ),
                            ),
                          );
                          if (typedValue != null) {
                            setState(() {
                              otherExpensesBudget = double.parse(typedValue);
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      child: Text(
                        'Money left: $moneyLeft $selectedCurrency',
                        style: kLabelTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          BottomButton(
            // CREATE BUDGET NUPP
            onTap: () {
              var budgetInfo = BudgetInfo(
                budgetName: budgetName,
                budgetAmount: budgetAmount,
                transportBudget: transportBudget,
                accomodationBudget: accomodationBudget,
                foodBudget: foodBudget,
                pastimeBudget: pastimeBudget,
                otherExpensesBudget: otherExpensesBudget,
                selectedCurrency: selectedCurrency,
              );
              // _budgetHelper.insertBudget(budgetInfo);
              if (moneyLeft < 0 || moneyLeft > 0) {
                showAlertDialogMoney(context);
              } else if (ifBudgetNameChanged == false || budgetName == null) {
                showAlertDialogBudgetName(context);
              } else if (budgetAmount == 0) {
                showAlertDialogBudgetAmount0(context);
              } else {
                print('On OK.');
                print('budgetName on $budgetName');
                print('budgetAmount on $budgetAmount');
                print('transportBudget on $transportBudget');
                print('accomodationBudget on $accomodationBudget');
                print('pastimeBudget on $pastimeBudget');
                print('otherExpensesBudget on $otherExpensesBudget');
                print('selectedCurrency on $selectedCurrency');
                _budgetHelper.insertBudget(budgetInfo);
                Navigator.pop(context);
              }
            },
            buttonTitle: 'CREATE BUDGET',
          )
        ],
      ),
    );
  }
}
