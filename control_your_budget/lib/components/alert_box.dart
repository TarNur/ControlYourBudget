import 'package:flutter/material.dart';

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
    content: Text('Either increase your Budget Amount or decrease Budget subcategory amounts.'),
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
