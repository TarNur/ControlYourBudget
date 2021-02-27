import 'package:control_your_budget/budget_helper.dart';
import 'package:control_your_budget/models/budget.dart';
import 'package:flutter/material.dart';
import 'package:control_your_budget/constants.dart';
import 'package:control_your_budget/components/bottom_create_button.dart';
import 'package:control_your_budget/screens/edit_value_screen.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class NewBudget extends StatefulWidget {
  @override
  _NewBudgetState createState() => _NewBudgetState();
}

class _NewBudgetState extends State<NewBudget> {
  BudgetHelper _budgetHelper = BudgetHelper();

  String budgetName = 'Prantsusmaa reis';
  double budgetAmount = 1500;
  double moneyLeft = 0;
  double transportBudget = 1500;
  double foodBudget = 1500;
  double accomodationBudget = 1500;
  double pastimeBudget = 1500;
  double otherExpensesBudget = 1500;
  String selectedCurrency = 'EUR';

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
              margin: EdgeInsets.all(15.0),
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
                  Icon(
                    Icons.edit,
                    size: 30.0,
                    color: Colors.cyan,
                  ),
                ],
              ),
            ),
          ),
          // BUDGET AMOUNT SISESTUS
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.all(15.0),
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
                  Icon(
                    Icons.edit,
                    size: 30.0,
                    color: Colors.cyan,
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 60.0,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            color: Colors.cyan,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
          Expanded(
            flex: 4,
            child: Container(
              margin: EdgeInsets.all(15.0),
              padding: EdgeInsets.only(
                  left: 5.0, right: 5.0, top: 10.0, bottom: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              // ALAMKATEGOORIAD
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Transport Budget: $transportBudget $selectedCurrency',
                        style: kLabelTextStyle,
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        iconSize: 30.0,
                        color: Colors.cyan,
                        onPressed: () {
                          print('pressed');
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) => SingleChildScrollView(
                                      child: Container(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: AddTaskScreen(),
                                  )));
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Accomodation budget: $accomodationBudget $selectedCurrency',
                        style: kLabelTextStyle,
                      ),
                      Icon(
                        Icons.edit,
                        size: 30.0,
                        color: Colors.cyan,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Food Budget: $foodBudget $selectedCurrency',
                        style: kLabelTextStyle,
                      ),
                      Icon(
                        Icons.edit,
                        size: 30.0,
                        color: Colors.cyan,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Pastime Budget: $pastimeBudget $selectedCurrency',
                        style: kLabelTextStyle,
                      ),
                      Icon(
                        Icons.edit,
                        size: 30.0,
                        color: Colors.cyan,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Other Expenses: $otherExpensesBudget $selectedCurrency',
                        style: kLabelTextStyle,
                      ),
                      Icon(
                        Icons.edit,
                        size: 30.0,
                        color: Colors.cyan,
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
              print('bottom button pressed');
            },
            buttonTitle: 'CREATE BUDGET',
          )
        ],
      ),
    );
  }
}
