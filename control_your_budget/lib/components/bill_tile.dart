import 'package:flutter/material.dart';
import 'package:control_your_budget/budget_helper.dart';


class BillTile extends StatelessWidget {
  final int id;
  final int billID;
  final String billName;
  final double billAmount;
  final String billSubcategory;
  final String paymentType;
  final int reimbursable;

  BillTile(
      {this.id, this.billID, this.billName, this.billAmount, this.billSubcategory, this.paymentType, this.reimbursable});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: GestureDetector(
        child: Text(
          'Bill: $billName', // TODO: Vaja lisada Nupp
          style: TextStyle(
            color: Colors.cyan,
            fontSize: 20.0,
          ),
        ),
        onTap: (){
          print('pressed view budget');
        },
      ),
      subtitle: Text(
        'Amount: $billAmount, Reimbursable: $reimbursable, Payed with $paymentType',
      ),
      trailing: Material(
        color: Colors.white,
        child: IconButton(
            icon: Icon(Icons.delete),
            iconSize: 25.0,
            splashColor: Colors.redAccent,
            splashRadius: 40.0,
            color: Colors.red,
            onPressed: () {
              //BudgetHelper().deleteBill(billID);
              print('deleteida veel ei saa');
            }),
      ),
    );
  }
}
