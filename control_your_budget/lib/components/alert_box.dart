import 'package:flutter/material.dart';
import 'package:control_your_budget/budget_helper.dart';

showAlertDialogMoney(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("I understand."),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text('Your money left needs to be zero.'),
    content: Text(
        'Either increase your Budget Amount or decrease Budget subcategory amounts.'),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialogBudgetName(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("I understand."),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text('Budget Name is invalid.'),
    content: Text('Your Budget Name is unchanged or nothing, change it.'),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialogBudgetAmount0(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("I understand."),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text('Budget Amount can\'t be zero.'),
    content: Text('Increase your Budget amount.'),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialogImageUploaded(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("Continue."),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text('Image Uploaded Successfully'),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialogBillName(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("I understand."),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text('Bill name is invalid.'),
    content: Text('Your Bill Name is unchanged or nothing, change it.'),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialogBillAmount0(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("I understand."),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text('Bill Amount can\'t be zero.'),
    content: Text('Increase your Bill amount.'),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialogBillNameNullAfterEdit(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("I understand."),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text('Bill name is invalid.'),
    content: Text('Your Bill Name is nothing, change it.'),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialogSaveImage(BuildContext context, String message) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("I understand."),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(message),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialogEmailResponse(BuildContext context, String result) {
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text('Email result: $result.'),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialogDeleteBudget(BuildContext context, int deleteBudgetID) {
  // set up the button
  Widget deleteButton = FlatButton(
    child: Text("Confirm"),
    onPressed: () {
      BudgetHelper().deleteAllBillsFromBudget(deleteBudgetID);
      BudgetHelper().deleteBudget(deleteBudgetID);
      
      Navigator.of(context).pop();
      return 1;
    },
  );

  Widget cancelButton = FlatButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
      return 0;
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text('Are you sure you wanted to delete this budget?'),
    content: Text('All of its bills will also be deleted.'),
    actions: [
      cancelButton,
      deleteButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
