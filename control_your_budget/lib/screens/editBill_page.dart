import 'package:flutter/material.dart';
import 'package:control_your_budget/budget_helper.dart';
import 'package:control_your_budget/models/budget.dart';
import 'package:control_your_budget/constants.dart';
import 'package:control_your_budget/components/bottom_create_button.dart';
import 'package:control_your_budget/screens/edit_value_screen.dart';
import 'package:control_your_budget/screens/edit_text_value_screen.dart';
import 'package:control_your_budget/screens/viewBills_page.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class EditBill extends StatefulWidget {
  final BillInfo bill;

  EditBill({this.bill});

  @override
  _EditBillState createState() => _EditBillState();
}

class _EditBillState extends State<EditBill> {
  BudgetHelper _budgetHelper = BudgetHelper();
  int once = 0;

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
      backgroundColor: Colors.white,
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
      backgroundColor: Colors.white,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          paymentType = paymentTypes[selectedIndex];
        });
      },
      children: pickerItems,
    );
  }

  String getSubcategoryFormat(String subCategory) {
    String correctFormatSubcategory;
    if (subCategory == 'Transport') {
      correctFormatSubcategory = 'transportBudget';
    } else if (subCategory == 'Accommodation') {
      correctFormatSubcategory = 'accomodationBudget';
    } else if (subCategory == 'Food') {
      correctFormatSubcategory = 'foodBudget';
    } else if (subCategory == 'Pastime') {
      correctFormatSubcategory = 'pastimeBudget';
    } else {
      correctFormatSubcategory = 'otherExpensesBudget';
    }
    return correctFormatSubcategory;
  }

  void fromSubcategoryFormat(String subCategory) {
    if (subCategory == 'transportBudget') {
      subCategory = 'Transport';
    } else if (subCategory == 'accomodationBudget') {
      subCategory = 'Accommodation';
    } else if (subCategory == 'foodBudget') {
      subCategory = 'Food';
    } else if (subCategory == 'pastimeBudget') {
      subCategory = 'Pastime';
    } else {
      subCategory = 'otherExpensesBudget';
    }
  }

  String billName;
  double billAmount;
  String paymentType;
  String subCategory;
  bool reimbursable;

  double prevBillAmount;

  @override
  Widget build(BuildContext context) {
    if (once == 0) {
      billName = widget.bill.billName;
      billAmount = widget.bill.billAmount;
      prevBillAmount = widget.bill.billAmount;
      paymentType = widget.bill.paymentType;
      subCategory = widget.bill.billSubcategory;
      fromSubcategoryFormat(subCategory);
      reimbursable = widget.bill.reimbursable == 0 ? false : true;
    }
    once = 1;
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
                    'Bill Amount: $billAmount',
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Payment Type: $paymentType',
                    style: kLabelTextStyle,
                  ),
                  Container(
                    height: 40.0,
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 0),
                    color: Colors.white,
                    child: Platform.isIOS ? iOSPicker2() : androidDropdown2(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Reimbursable?',
                        style: kLabelTextStyle,
                      ),
                      Checkbox(
                          value: reimbursable,
                          activeColor: Colors.cyan,
                          onChanged: (value) {
                            setState(() {
                              reimbursable = !reimbursable;
                            });
                          })
                    ],
                  ),
                  Text('Date ja pildi lisamine...')
                ],
              ),
            ),
          ),
          BottomButton(
            // CREATE BUDGET NUPP
            onTap: () async {
              int ifReimbursable = reimbursable ? 1 : 0;
              String correctSubcategory = getSubcategoryFormat(subCategory);
              var updatedBill = BillInfo(
                billID: widget.bill.billID,
                billName: billName,
                billAmount: billAmount,
                id: widget.bill.id,
                billSubcategory: correctSubcategory,
                paymentType: paymentType,
                reimbursable: ifReimbursable,
              );
              BudgetInfo currentBudget =
                  await _budgetHelper.getBudget(widget.bill.id);
              _budgetHelper.updateBudgetAmountsLeft(widget.bill.id, subCategory,
                  currentBudget, billAmount - prevBillAmount);
              _budgetHelper.updateBill(updatedBill);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => ViewBills(
                      budgetID: widget.bill.id, budgetSubcategory: subCategory),
                ),
              );
            },
            buttonTitle: 'EDIT BILL',
          )
        ],
      ),
    );
  }
}
