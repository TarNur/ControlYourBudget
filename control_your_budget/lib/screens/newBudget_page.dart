import 'package:flutter/material.dart';
import 'package:control_your_budget/constants.dart';
import 'package:control_your_budget/components/bottom_create_button.dart';
import 'package:control_your_budget/components/alert_box.dart';
import 'package:flutter/services.dart';

class NewBudget extends StatefulWidget {
  @override
  _NewBudgetState createState() => _NewBudgetState();
}

class _NewBudgetState extends State<NewBudget> {
  var budgetName = TextEditingController();
  var budgetAmount = TextEditingController();
  double moneyLeft = 0;
  var transportBudget = TextEditingController();
  var foodBudget = TextEditingController();
  var accomodationBudget = TextEditingController();
  var pastimeBudget = TextEditingController();
  var otherExpensesBudget = TextEditingController();

  void updateMoneyLeft() {
    moneyLeft = double.parse(budgetAmount.text) -
        double.parse(transportBudget.text) -
        double.parse(accomodationBudget.text) -
        double.parse(foodBudget.text) -
        double.parse(pastimeBudget.text) -
        double.parse(otherExpensesBudget.text);
  }

  void checkAmount(var budget) {
    if (budget.text == '') {
      budget.value = TextEditingValue(text: '0');
    }
  }

  void checkAllAmounts() {
    checkAmount(budgetAmount);
    checkAmount(transportBudget);
    checkAmount(foodBudget);
    checkAmount(accomodationBudget);
    checkAmount(pastimeBudget);
    checkAmount(otherExpensesBudget);
  }

  void addToOtherExpenses() {
    otherExpensesBudget.value = TextEditingValue(
      text: (double.parse(otherExpensesBudget.text) + moneyLeft).toString(),
    );
  }

  TextField createSubCat(String categoryName, var budgetCategory) {
    return TextField(
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(r'^\d*[.]?\d?\d?'),
        ),
      ],
      controller: budgetCategory,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: categoryName,
        hintText: 'Money left from budget: $moneyLeft',
      ),
      onTap: () {
        setState(() {
          checkAllAmounts();
          updateMoneyLeft();
        });
      },
    );
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
                color: kInactiveCardColour,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextFormField(
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: 'Enter name for Budget',
                  labelText: 'Budget Name:',
                ),
                maxLength: 15,
                controller: budgetName,
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
                color: kInactiveCardColour,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d*[.]?\d?\d?'),
                  ),
                ],
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: 'Enter Budget amount',
                  labelText: 'Budget:',
                ),
                controller: budgetAmount,
                maxLength: 15,
                onTap: () {
                  setState(() {
                    checkAllAmounts();
                    updateMoneyLeft();
                  });
                },
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              margin: EdgeInsets.all(15.0),
              padding: EdgeInsets.only(
                left: 10.0,
                right: 10.0,
                top: 20.0,
              ),
              decoration: BoxDecoration(
                color: kInactiveCardColour,
                borderRadius: BorderRadius.circular(10.0),
              ),
              // ALAMKATEGOORIAD
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //TRANSPORT ALAMKATEGOORIA
                  Text(
                    'Money left from Initial Budget: $moneyLeft',
                    style: kLabelTextStyle,
                  ),
                  SizedBox(height: 15.0),
                  Expanded(
                    child: createSubCat('Transport Budget', transportBudget),
                  ),
                  //ACCOMODATION ALAMKATEGOORIA
                  Expanded(
                    child:
                        createSubCat('Accomodation Budget', accomodationBudget),
                  ),
                  //FOOD ALAMKATEGOORIA
                  Expanded(
                    child: createSubCat('Food Budget', foodBudget),
                  ),
                  //PASTIME ALAMKATEGOORIA
                  Expanded(
                    child: createSubCat('Pastime Budget', pastimeBudget),
                  ),
                  //OTHER EXPENSES ALAMKATEGOORIA
                  Expanded(
                    child: createSubCat('Other Expenses', otherExpensesBudget),
                  ),
                ],
              ),
            ),
          ),
          BottomButton(
            // CREATE BUDGET NUPP
            onTap: () {
              checkAllAmounts();

              if (moneyLeft > 0) {
                // Kui raha üle, pane muud kulud alla.
                addToOtherExpenses();
                updateMoneyLeft();
              }

              if (moneyLeft < 0) {
                showAlertDialog(context); //ALERT SIIT
              } else {
                print('On OK.');
              }
            },
            buttonTitle: 'CREATE BUDGET',
          )
        ],
      ),
    );
  }
}
