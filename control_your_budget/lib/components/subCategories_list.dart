import 'package:control_your_budget/models/budget.dart';
import 'package:control_your_budget/budget_helper.dart';
import 'package:control_your_budget/screens/viewBills_page.dart';
import 'package:control_your_budget/screens/viewBudget_page.dart';
import 'package:flutter/material.dart';

class BudgetsList extends StatefulWidget {
  //TODO: Nimi vaja muuta
  final BudgetInfo budgets;

  BudgetsList(this.budgets);

  @override
  _BudgetsListState createState() => _BudgetsListState();
}

class _BudgetsListState extends State<BudgetsList> {
  BudgetHelper _budgetHelper = BudgetHelper();

  TextStyle getColor(double moneyLeft, double money) {
    if (moneyLeft / money < 0) {
      return TextStyle(
        fontSize: 12.0,
        color: Colors.red,
      );
    } else if (moneyLeft / money < 0.2) {
      return TextStyle(
        fontSize: 12.0,
        color: Colors.yellow[800],
      );
    } else {
      return TextStyle(
        fontSize: 12.0,
        color: Colors.green,
      );
    }
  }

  @override
  void initState() {
    _budgetHelper.initializeDatabase().then((value) {
      print('-----------database initialized');
      loadBudget();
    });
    super.initState();
  }

  void loadBudget() {
    _budgetHelper.getSingleSubCategoryBills(
        widget.budgets.id, 'transportBudget');
    if (mounted) setState(() {});
  }

  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text(
            'Budget Amount',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
            ),
          ),
          subtitle: Text(
            '  Money left: ${widget.budgets.budgetAmountLeft} of ${widget.budgets.budgetAmount}${widget.budgets.selectedCurrency}',
            style: getColor(
                widget.budgets.budgetAmountLeft, widget.budgets.budgetAmount),
          ),
        ),
        ListTile(
          title: Text(
            'Transport Budget',
            style: TextStyle(
              color: Colors.cyan,
              fontSize: 20.0,
            ),
          ),
          trailing: Material(
            color: Colors.white,
            child: IconButton(
                icon: Icon(Icons.folder_open),
                iconSize: 25.0,
                splashColor: Colors.cyan,
                splashRadius: 40.0,
                color: Colors.cyan,
                onPressed: () {
                  print('open');
                  _budgetHelper.getSingleSubCategoryBills(
                      widget.budgets.id, 'transportBudget');
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => ViewBills(
                        budgetID: widget.budgets.id,
                        budgetSubcategory: 'transportBudget',
                        selectedCurrency: widget.budgets.selectedCurrency,
                      ),
                    ),
                  );
                }),
          ),
          subtitle: Text(
            '  Money left: ${widget.budgets.transportBudgetLeft} of ${widget.budgets.transportBudget}${widget.budgets.selectedCurrency}',
            style: getColor(widget.budgets.transportBudgetLeft,
                widget.budgets.transportBudget),
          ),
        ),
        SizedBox(
          height: 2.0,
        ),
        ListTile(
          title: Text(
            'Accommodation Budget',
            style: TextStyle(
              color: Colors.cyan,
              fontSize: 20.0,
            ),
          ),
          subtitle: Text(
            '  Money left: ${widget.budgets.accomodationBudgetLeft} of ${widget.budgets.accomodationBudget}${widget.budgets.selectedCurrency}',
            style: getColor(widget.budgets.accomodationBudgetLeft,
                widget.budgets.accomodationBudget),
          ),
          trailing: Material(
            color: Colors.white,
            child: IconButton(
                icon: Icon(Icons.folder_open),
                iconSize: 25.0,
                splashColor: Colors.cyan,
                splashRadius: 40.0,
                color: Colors.cyan,
                onPressed: () {
                  print('open');
                  _budgetHelper.getSingleSubCategoryBills(
                      widget.budgets.id, 'accomodationBudget');
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => ViewBills(
                        budgetID: widget.budgets.id,
                        budgetSubcategory: 'accomodationBudget',
                        selectedCurrency: widget.budgets.selectedCurrency,
                      ),
                    ),
                  );
                }),
          ),
        ),
        SizedBox(
          height: 2.0,
        ),
        ListTile(
          title: Text(
            'Food Budget',
            style: TextStyle(
              color: Colors.cyan,
              fontSize: 20.0,
            ),
          ),
          subtitle: Text(
            '  Money left: ${widget.budgets.foodBudgetLeft} of ${widget.budgets.foodBudget}${widget.budgets.selectedCurrency}',
            style: getColor(
                widget.budgets.foodBudgetLeft, widget.budgets.foodBudget),
          ),
          trailing: Material(
            color: Colors.white,
            child: IconButton(
                icon: Icon(Icons.folder_open),
                iconSize: 25.0,
                splashColor: Colors.cyan,
                splashRadius: 40.0,
                color: Colors.cyan,
                onPressed: () {
                  print('open');
                  _budgetHelper.getSingleSubCategoryBills(
                      widget.budgets.id, 'foodBudget');
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => ViewBills(
                        budgetID: widget.budgets.id,
                        budgetSubcategory: 'foodBudget',
                        selectedCurrency: widget.budgets.selectedCurrency,
                      ),
                    ),
                  );
                }),
          ),
        ),
        SizedBox(
          height: 2.0,
        ),
        ListTile(
          title: Text(
            'Pastime Budget',
            style: TextStyle(
              color: Colors.cyan,
              fontSize: 20.0,
            ),
          ),
          subtitle: Text(
            '  Money left: ${widget.budgets.pastimeBudgetLeft} of ${widget.budgets.pastimeBudget}${widget.budgets.selectedCurrency}',
            style: getColor(
                widget.budgets.pastimeBudgetLeft, widget.budgets.pastimeBudget),
          ),
          trailing: Material(
            color: Colors.white,
            child: IconButton(
                icon: Icon(Icons.folder_open),
                iconSize: 25.0,
                splashColor: Colors.cyan,
                splashRadius: 40.0,
                color: Colors.cyan,
                onPressed: () {
                  print('open');
                  _budgetHelper.getSingleSubCategoryBills(
                      widget.budgets.id, 'pastimeBudget');
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => ViewBills(
                        budgetID: widget.budgets.id,
                        budgetSubcategory: 'pastimeBudget',
                        selectedCurrency: widget.budgets.selectedCurrency,
                      ),
                    ),
                  );
                }),
          ),
        ),
        SizedBox(
          height: 2.0,
        ),
        ListTile(
          title: Text(
            'Other Expenses',
            style: TextStyle(
              color: Colors.cyan,
              fontSize: 20.0,
            ),
          ),
          subtitle: Text(
            '  Money left: ${widget.budgets.otherExpensesBudgetLeft} of ${widget.budgets.otherExpensesBudget}${widget.budgets.selectedCurrency}',
            style: getColor(widget.budgets.otherExpensesBudgetLeft,
                widget.budgets.otherExpensesBudget),
          ),
          trailing: Material(
            color: Colors.white,
            child: IconButton(
                icon: Icon(Icons.folder_open),
                iconSize: 25.0,
                splashColor: Colors.cyan,
                splashRadius: 40.0,
                color: Colors.cyan,
                onPressed: () {
                  print('open');
                  _budgetHelper.getSingleSubCategoryBills(
                      widget.budgets.id, 'otherExpensesBudget');
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => ViewBills(
                        budgetID: widget.budgets.id,
                        budgetSubcategory: 'otherExpensesBudget',
                        selectedCurrency: widget.budgets.selectedCurrency,
                      ),
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }
}
