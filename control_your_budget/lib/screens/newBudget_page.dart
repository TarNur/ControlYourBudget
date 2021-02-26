import 'package:flutter/material.dart';
import 'package:control_your_budget/constants.dart';
import 'package:control_your_budget/components/bottom_create_button.dart';
import 'package:flutter/services.dart';
import 'package:control_your_budget/budget.dart';

class NewBudget extends StatefulWidget {
  @override
  _NewBudgetState createState() => _NewBudgetState();
}

class _NewBudgetState extends State<NewBudget> {
  String budgetName;
  double budgetAmount = 0;
  double moneyLeft = 0;
  double transportBudget = 0;
  double accomodationBudget = 0;
  double foodBudget = 0;
  double pastimeBudget = 0;
  double otherExpensesBudget = 0;

  void updateName(String text) {
    // Uuenda Budgeti nimi
    budgetName = text;
  }

  double updateMoneyAmount(String text) {
    // Uuenda rahaline väärtus
    return double.parse(text);
  }

  void updateMoneyLeft() {
    moneyLeft = budgetAmount -
        (transportBudget +
            accomodationBudget +
            foodBudget +
            pastimeBudget +
            otherExpensesBudget);
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
                onChanged: (text) {
                  updateName(text);
                },
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
                    budgetAmount = updateMoneyAmount(text);
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*[.]?\d?\d?'),
                              ),
                            ],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Transport Budget',
                              hintText: 'Money left from budget: $moneyLeft',
                            ),
                            onChanged: (text) {
                              setState(
                                () {
                                  transportBudget = updateMoneyAmount(text);
                                  updateMoneyLeft();
                                },
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  //ACCOMODATION ALAMKATEGOORIA
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*[.]?\d?\d?'),
                              ),
                            ],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Accomodation Budget',
                              hintText: 'Money left from budget: $moneyLeft',
                            ),
                            onChanged: (text) {
                              setState(
                                () {
                                  accomodationBudget = updateMoneyAmount(text);
                                  updateMoneyLeft();
                                },
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  //FOOD ALAMKATEGOORIA
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*[.]?\d?\d?'),
                              ),
                            ],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Food budget',
                              hintText: 'Money left from budget: $moneyLeft',
                            ),
                            onChanged: (text) {
                              setState(
                                () {
                                  foodBudget = updateMoneyAmount(text);
                                  updateMoneyLeft();
                                },
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  //PASTIME ALAMKATEGOORIA
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*[.]?\d?\d?'),
                              ),
                            ],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Pastime Budget',
                              hintText: 'Money left from budget: $moneyLeft',
                            ),
                            onChanged: (text) {
                              setState(
                                () {
                                  pastimeBudget = updateMoneyAmount(text);
                                  updateMoneyLeft();
                                },
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  //OTHER EXPENSES ALAMKATEGOORIA
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*[.]?\d?\d?'),
                              ),
                            ],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Other Expenses',
                              hintText: 'Money left from budget: $moneyLeft',
                            ),
                            onChanged: (text) {
                              setState(
                                () {
                                  otherExpensesBudget = updateMoneyAmount(text);
                                  updateMoneyLeft();
                                },
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          BottomButton(
            // CREATE BUDGET NUPP
            onTap: () {
              print('Budget\'i nimi on $budgetName ja amount on $budgetAmount');
              Budget(budgetName: budgetName, fullBudgetAmount: budgetAmount)
                  .printData();
            },
            buttonTitle: 'CREATE BUDGET',
          )
        ],
      ),
    );
  }
}
