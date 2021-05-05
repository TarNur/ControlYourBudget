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

class EditBudget extends StatefulWidget {
  final BudgetInfo budget;

  EditBudget({this.budget});
  @override
  _EditBudgetState createState() => _EditBudgetState();
}

class _EditBudgetState extends State<EditBudget> {
  BudgetHelper _budgetHelper = BudgetHelper();
  int once = 0;

  String budgetName;
  double budgetAmount;
  double moneyLeft;
  double transportBudget;
  double foodBudget;
  double accomodationBudget;
  double pastimeBudget;
  double otherExpensesBudget;
  String selectedCurrency;

  double previousBudgetAmount;
  double previousTransportBudget;
  double previousFoodBudget;
  double previousAccomodationBudget;
  double previousPastimeBudget;
  double previousOtherExpensesBudget;

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

  Row subCategoryInput(
      String subCatName, double subCatAmount, IconButton changeValueButton) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      // TRANSPORT BUDGET
      children: [
        Text(
          '$subCatName $subCatAmount $selectedCurrency',
          style: kLabelTextStyle,
        ),
        changeValueButton,
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (once == 0) {
      budgetName = widget.budget.budgetName;
      budgetAmount = widget.budget.budgetAmount;
      transportBudget = widget.budget.transportBudget;
      foodBudget = widget.budget.foodBudget;
      accomodationBudget = widget.budget.accomodationBudget;
      pastimeBudget = widget.budget.pastimeBudget;
      otherExpensesBudget = widget.budget.otherExpensesBudget;
      selectedCurrency = widget.budget.selectedCurrency;
      previousBudgetAmount = widget.budget.budgetAmount;
      previousTransportBudget = widget.budget.transportBudget;
      previousFoodBudget = widget.budget.foodBudget;
      previousAccomodationBudget = widget.budget.accomodationBudget;
      previousPastimeBudget = widget.budget.pastimeBudget;
      previousOtherExpensesBudget = widget.budget.otherExpensesBudget;
    }
    once = 1;
    moneyLeft = budgetAmount -
        transportBudget -
        foodBudget -
        accomodationBudget -
        pastimeBudget -
        otherExpensesBudget;
    moneyLeft = double.parse(moneyLeft.toStringAsFixed(2));
    if (moneyLeft == -0.00 || moneyLeft == -0.0) {
      moneyLeft = moneyLeft.abs();
    }
    previousBudgetAmount = widget.budget.budgetAmount;
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
                          budgetAmount =
                              double.parse((budgetAmount).toStringAsFixed(2));
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
                  subCategoryInput(
                    'Transport Budget:              ',
                    transportBudget,
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
                            transportBudget = double.parse(typedValue);
                            transportBudget = double.parse(
                                (transportBudget).toStringAsFixed(2));
                          });
                        }
                      },
                    ),
                  ),
                  subCategoryInput(
                    'Accommodation Budget:   ',
                    accomodationBudget,
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
                            accomodationBudget = double.parse(typedValue);
                            accomodationBudget = double.parse(
                                (accomodationBudget).toStringAsFixed(2));
                          });
                        }
                      },
                    ),
                  ),
                  subCategoryInput(
                    'Food Budget:                      ',
                    foodBudget,
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
                            foodBudget = double.parse(typedValue);
                            foodBudget =
                                double.parse((foodBudget).toStringAsFixed(2));
                          });
                        }
                      },
                    ),
                  ),
                  subCategoryInput(
                    'Pastime Budget:                 ',
                    pastimeBudget,
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
                            pastimeBudget = double.parse(typedValue);
                            pastimeBudget = double.parse(
                                (pastimeBudget).toStringAsFixed(2));
                          });
                        }
                      },
                    ),
                  ),
                  subCategoryInput(
                    'Other Expenses:                 ',
                    otherExpensesBudget,
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
                            otherExpensesBudget = double.parse(typedValue);
                            otherExpensesBudget = double.parse(
                                (otherExpensesBudget).toStringAsFixed(2));
                          });
                        }
                      },
                    ),
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
            // 700 -> 1000 1000-700 = 300
            onTap: () {
              var budgetInfo = BudgetInfo(
                id: widget.budget.id,
                budgetName: budgetName,
                budgetAmount: budgetAmount,
                transportBudget: transportBudget,
                accomodationBudget: accomodationBudget,
                foodBudget: foodBudget,
                pastimeBudget: pastimeBudget,
                otherExpensesBudget: otherExpensesBudget,
                selectedCurrency: selectedCurrency,
                budgetAmountLeft: double.parse((widget.budget.budgetAmountLeft +
                        (budgetAmount - previousBudgetAmount))
                    .toStringAsFixed(2)),
                transportBudgetLeft: double.parse(
                    (widget.budget.transportBudgetLeft +
                            (transportBudget - previousTransportBudget))
                        .toStringAsFixed(2)),
                accomodationBudgetLeft: double.parse(
                    (widget.budget.accomodationBudgetLeft +
                            (accomodationBudget - previousAccomodationBudget))
                        .toStringAsFixed(2)),
                foodBudgetLeft: double.parse((widget.budget.foodBudgetLeft +
                        (foodBudget - previousFoodBudget))
                    .toStringAsFixed(2)),
                pastimeBudgetLeft: double.parse(
                    (widget.budget.pastimeBudgetLeft +
                            (pastimeBudget - previousPastimeBudget))
                        .toStringAsFixed(2)),
                otherExpensesBudgetLeft: double.parse(
                    (widget.budget.otherExpensesBudgetLeft +
                            (otherExpensesBudget - previousOtherExpensesBudget))
                        .toStringAsFixed(2)),
              );
              // _budgetHelper.insertBudget(budgetInfo);
              if (moneyLeft < 0 || moneyLeft > 0) {
                showAlertDialogMoney(context);
              } else if (budgetName == null || budgetName == '') {
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
                _budgetHelper.updateBudget(budgetInfo);
                Navigator.pop(context);
              }
            },
            buttonTitle: 'SAVE',
          )
        ],
      ),
    );
  }
}
