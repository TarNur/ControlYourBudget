import 'package:flutter/material.dart';
import 'package:control_your_budget/constants.dart';
import 'package:control_your_budget/components/bottom_create_button.dart';
import 'package:flutter/services.dart';

class NewBudget extends StatefulWidget {
  @override
  _NewBudgetState createState() => _NewBudgetState();
}

class _NewBudgetState extends State<NewBudget> {
  var budgetName = TextEditingController();

  double budgetAmount = 0;
  double moneyLeft = 0;

  var transportBudget = TextEditingController();
  var foodBudget = TextEditingController();
  var accomodationBudget = TextEditingController();
  var pastimeBudget = TextEditingController();
  var otherExpensesBudget = TextEditingController();

  void updateMoneyLeft() {
    moneyLeft = budgetAmount;
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                maxLength: 15,
                onChanged: (text) {
                  setState(() {
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //TRANSPORT ALAMKATEGOORIA
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
              print(budgetName.text);
              if (transportBudget.text == '') {
                print('Fuck you');
              }
            },
            buttonTitle: 'CREATE BUDGET',
          )
        ],
      ),
    );
  }
}
