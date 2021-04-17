import 'package:control_your_budget/models/budget.dart';
import 'package:flutter/material.dart';
import 'bill_tile.dart';

class BillsList extends StatefulWidget {
  final List<BillInfo> bills;

  BillsList(this.bills);

  @override
  _BillsListState createState() => _BillsListState();
}

class _BillsListState extends State<BillsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return BillTile(
          id: widget.bills[index].id,
          billID: widget.bills[index].billID,
          billName: widget.bills[index].billName,
          billAmount: widget.bills[index].billAmount,
          billSubcategory: widget.bills[index].billSubcategory,
          paymentType: widget.bills[index].paymentType,
          reimbursable: widget.bills[index].reimbursable,
        );
      },
      itemCount: widget.bills.length,
    );
  }
}
