import 'package:flutter/material.dart';
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
  DropdownButton<String> androidDropdown() {
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

  CupertinoPicker iOSPicker() {
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
                    child: Platform.isIOS ? iOSPicker() : androidDropdown(),
                  ),
                ],
              ),
            ),
          ),
          BottomButton(
            // CREATE BUDGET NUPP
            onTap: () {
              print('bottom button pressed');
              print('Bill Amount: $billAmount $selectedCurrency');
              print('BudgetID: $budgetID');
              print('Bill name: $billName');
              print('Bill reimbursable: $reimbursable');
              print('Payment: $paymentType');
            },
            buttonTitle: 'CREATE BILL',
          )
        ],
      ),
    );
  }
}
