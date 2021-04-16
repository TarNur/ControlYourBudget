import 'package:flutter/material.dart';
import 'package:control_your_budget/budget_helper.dart';
import 'package:control_your_budget/models/budget.dart';
import 'package:control_your_budget/constants.dart';
import 'package:control_your_budget/components/bottom_create_button.dart';
import 'package:control_your_budget/screens/edit_value_screen.dart';
import 'package:control_your_budget/screens/edit_text_value_screen.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class NewBill extends StatefulWidget {
  final int budgetID;
  final String selectedCurrency;

  NewBill({this.budgetID, this.selectedCurrency});

  @override
  _NewBillState createState() => _NewBillState();
}

class _NewBillState extends State<NewBill> {
  BudgetHelper _budgetHelper = BudgetHelper();

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String subCategory in subCategories) {
      var newItem = DropdownMenuItem(
        child: Text(subCategory),
        value: subCategory,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: subCategory,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          subCategory = value;
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String subCategory in subCategories) {
      pickerItems.add(Text(subCategory));
    }

    return CupertinoPicker(
      backgroundColor: Colors.cyan,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          subCategory = subCategories[selectedIndex];
        });
      },
      children: pickerItems,
    );
  }

  DropdownButton<String> androidDropdown2() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String paymentType in paymentTypes) {
      var newItem = DropdownMenuItem(
        child: Text(paymentType),
        value: paymentType,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: paymentType,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          paymentType = value;
        });
      },
    );
  }

  CupertinoPicker iOSPicker2() {
    List<Text> pickerItems = [];
    for (String paymentType in paymentTypes) {
      pickerItems.add(Text(paymentType));
    }

    return CupertinoPicker(
      backgroundColor: Colors.cyan,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          paymentType = paymentTypes[selectedIndex];
        });
      },
      children: pickerItems,
    );
  }

  String billName = 'Enter Bill Name';
  int budgetID;
  double billAmount = 0;
  String paymentType = 'Credit Card';
  String subCategory = 'transportBudget';
  String selectedCurrency;
  bool ifBudgetNameChanged = false;
  bool reimbursable = false;

  @override
  Widget build(BuildContext context) {
    budgetID = widget.budgetID;
    selectedCurrency = widget.selectedCurrency;
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
                    'Bill Name: $billName',
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
                          billName = typedValue;
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
                    'Bill Amount: $billAmount $selectedCurrency',
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
                          billAmount = double.parse(typedValue);
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
                        'Reimbursable?',
                        style: kLabelTextStyle,
                      ),
                      Checkbox(
                          value: reimbursable,
                          onChanged: (value) {
                            setState(() {
                              reimbursable = !reimbursable;
                            });
                          })
                    ],
                  ),
                  Container(
                    height: 55.0,
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    color: Colors.cyan,
                    child: Platform.isIOS ? iOSPicker2() : androidDropdown2(),
                  ),
                ],
              ),
            ),
          ),
          BottomButton(
            // CREATE BUDGET NUPP
            onTap: () async {
              var billInfo = BillInfo(
                billName: billName,
                billAmount: billAmount,
                id: budgetID,
                billSubcategory: subCategory,
                paymentType: paymentType,
                reimbursable: reimbursable,
              );
              print('bottom button pressed');
              print('Bill Amount: $billAmount $selectedCurrency');
              print('BudgetID: $budgetID');
              print('Bill name: $billName');
              print('Subcategory: $subCategory');
              print('Bill reimbursable: $reimbursable');
              print('Payment: $paymentType');
              BudgetInfo currentBudget = await _budgetHelper.getBudget(budgetID);
              _budgetHelper.updateBudgetAmountsLeft(budgetID, subCategory, currentBudget, billAmount);
              currentBudget = await _budgetHelper.getBudget(budgetID);
              //_budgetHelper.insertBill(billInfo);
              //Navigator.pop(context);
            },
            buttonTitle: 'CREATE BILL',
          )
        ],
      ),
    );
  }
}
