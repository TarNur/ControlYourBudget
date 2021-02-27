import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BudgetTile extends StatelessWidget {
  final String budgetName;
  final double budgetAmount;
  final String selectedCurrency;

  BudgetTile({this.budgetName, this.budgetAmount, this.selectedCurrency});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        budgetName,
      ),
      subtitle: Text(
        '$budgetAmount $selectedCurrency',
      ),
      trailing: Icon(
        FontAwesomeIcons.folderOpen,
        size: 40.0,
        color: Colors.cyan,
      ),
    );
  }
}
