import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:control_your_budget/constants.dart';
import 'package:control_your_budget/components/alert_box.dart';
import 'package:control_your_budget/budget_helper.dart';
import 'package:control_your_budget/models/budget.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class EmailSender extends StatefulWidget {
  final int budgetID;

  EmailSender({this.budgetID});

  @override
  _EmailSenderState createState() => _EmailSenderState();
}

class _EmailSenderState extends State<EmailSender> {
  List<String> attachments = [];
  bool isHTML = false;
  String body = 'Your Budget Report \n\n';

  final _recipientController = TextEditingController(
    text: 'reciepient@example.com',
  );

  final _subjectController = TextEditingController(text: 'Enter Email Subject');

  Future<void> send() async {
    if (wantedBills == 'All') {
      createBody();
    } else if (wantedBills == 'Reimbursable') {
      createBodyForReimbursable(1);
    } else {
      createBodyForReimbursable(0);
    }
    final Email email = Email(
      body: body,
      subject: _subjectController.text,
      recipients: [_recipientController.text],
      attachmentPaths: attachments,
      isHTML: isHTML,
    );

    String platformResponse;
  
    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }

    showAlertDialogEmailResponse(context, platformResponse);
    if (!mounted) return;
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String wantedBills in reportOptions) {
      var newItem = DropdownMenuItem(
        child: Text(wantedBills),
        value: wantedBills,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: wantedBills,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          wantedBills = value;
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String wantedBills in reportOptions) {
      pickerItems.add(Text(wantedBills));
    }

    return CupertinoPicker(
      backgroundColor: Colors.white,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          wantedBills = reportOptions[selectedIndex];
        });
      },
      children: pickerItems,
    );
  }

  BudgetHelper _budgetHelper = BudgetHelper();
  BudgetInfo _budget;
  Future<BudgetInfo> _budgetinfo;
  List<BillInfo> _bills;
  List<BillInfo> transportBills = [];
  List<BillInfo> accomodationBills = [];
  List<BillInfo> foodBills = [];
  List<BillInfo> pastimeBills = [];
  List<BillInfo> otherBills = [];
  String wantedBills = 'All';

  @override
  void initState() {
    _budgetHelper.initializeDatabase().then((value) {
      loadBudget();
      print('-----------database initialized');
    });
    loadBudgetFuture();
    super.initState();
  }

  void loadBudget() async {
    _budget = await _budgetHelper.getBudget(widget.budgetID);
    _bills = await _budgetHelper.getSingleBudgetBills(widget.budgetID);
  }

  void loadBudgetFuture() {
    _budgetinfo = _budgetHelper.getBudget(widget.budgetID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('CONTROL YOUR BUDGET'),
      ),
      body: Container(
        padding:
            EdgeInsets.only(top: 40.0, left: 10.0, right: 10.0, bottom: 40.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Get Budget Report to Email',
              style: kLabelTextStyle,
            ),
            SizedBox(height: 40.0),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(8.0),
              child: TextField(
                style: kLabelTextStyle,
                controller: _recipientController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Recipient/To',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              color: Colors.white,
              child: TextField(
                controller: _subjectController,
                style: kLabelTextStyle,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Subject',
                ),
              ),
            ),
            Text(
              'Bills to be included in report:',
              style: TextStyle(color: Colors.cyan, fontSize: 20.0),
            ),
            Container(
              height: 55.0,
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              color: Colors.cyan,
              child: Platform.isIOS ? iOSPicker() : androidDropdown(),
            ),
            SizedBox(height: 30.0),
            FutureBuilder(
                future: _budgetinfo,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(children: [
                      Text(
                        'Selected Budget',
                        style: TextStyle(color: Colors.cyan, fontSize: 25.0),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'Budget Name: ${snapshot.data.budgetName}',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'Money spent: ${snapshot.data.budgetAmount - snapshot.data.budgetAmountLeft} of ${snapshot.data.budgetAmount}${snapshot.data.selectedCurrency}',
                        style: kLabelTextStyle,
                      ),
                    ]);
                  }
                  return Center(
                    child: Text(
                      'Loading...',
                      style: TextStyle(color: Colors.cyan, fontSize: 30.0),
                    ),
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // Create New Budget Button
        onPressed: () {
          send();
          Navigator.of(context).pop();
        },
        child: Icon(Icons.send),
        backgroundColor: Colors.cyan,
      ),
    );
  }

  void createBody() {
    _bills.forEach((bill) {
      if (bill.billSubcategory == 'transportBudget') {
        transportBills.add(bill);
      } else if (bill.billSubcategory == 'accomodationBudget') {
        accomodationBills.add(bill);
      } else if (bill.billSubcategory == 'foodBudget') {
        foodBills.add(bill);
      } else if (bill.billSubcategory == 'pastimeBudget') {
        pastimeBills.add(bill);
      } else {
        otherBills.add(bill);
      }
    });
    double spent = _budget.budgetAmount - _budget.budgetAmountLeft;
    String reimbursableformat;
    body = body +
        'Budget Name: ${_budget.budgetName}\n $spent spent of ${_budget.budgetAmount} ${_budget.selectedCurrency}\nBills: \n';
    spent = _budget.transportBudget - _budget.transportBudgetLeft;
    body = body +
        '  Transport: $spent spent of ${_budget.transportBudget} ${_budget.selectedCurrency}\n';
    transportBills.forEach((bill) {
      reimbursableformat =
          bill.reimbursable == 1 ? 'Is reimbursable' : 'Not reimbursable';
      body = body +
          '    ${bill.date} ${bill.billName}: ${bill.billAmount}${_budget.selectedCurrency}, $reimbursableformat, Payed with ${bill.paymentType}\n';
    });
    spent = _budget.accomodationBudget - _budget.accomodationBudgetLeft;
    body = body +
        '  Accommodation: $spent spent of ${_budget.accomodationBudget} ${_budget.selectedCurrency}\n';
    accomodationBills.forEach((bill) {
      reimbursableformat =
          bill.reimbursable == 1 ? 'Is reimbursable' : 'Not reimbursable';
      body = body +
          '    ${bill.date} ${bill.billName}: ${bill.billAmount}${_budget.selectedCurrency}, $reimbursableformat, Payed with ${bill.paymentType}\n';
    });
    spent = _budget.foodBudget - _budget.foodBudgetLeft;
    body = body +
        '  Food: $spent spent of ${_budget.foodBudget} ${_budget.selectedCurrency}\n';
    foodBills.forEach((bill) {
      reimbursableformat =
          bill.reimbursable == 1 ? 'Is reimbursable' : 'Not reimbursable';
      body = body +
          '    ${bill.date} ${bill.billName}: ${bill.billAmount}${_budget.selectedCurrency}, $reimbursableformat, Payed with ${bill.paymentType}\n';
    });
    spent = _budget.pastimeBudget - _budget.pastimeBudgetLeft;
    body = body +
        '  Pastime: $spent spent of ${_budget.pastimeBudget} ${_budget.selectedCurrency}\n';
    pastimeBills.forEach((bill) {
      reimbursableformat =
          bill.reimbursable == 1 ? 'Is reimbursable' : 'Not reimbursable';
      body = body +
          '    ${bill.date} ${bill.billName}: ${bill.billAmount}${_budget.selectedCurrency}, $reimbursableformat, Payed with ${bill.paymentType}\n';
    });
    spent = _budget.otherExpensesBudget - _budget.otherExpensesBudgetLeft;
    body = body +
        '  Other: $spent spent of ${_budget.otherExpensesBudget} ${_budget.selectedCurrency}\n';
    otherBills.forEach((bill) {
      reimbursableformat =
          bill.reimbursable == 1 ? 'Is reimbursable' : 'Not reimbursable';
      body = body +
          '    ${bill.date} ${bill.billName}: ${bill.billAmount}${_budget.selectedCurrency}, $reimbursableformat, Payed with ${bill.paymentType}\n';
    });
  }

  void createBodyForReimbursable(int trueOrFalse) {
    double spent = _budget.budgetAmount - _budget.budgetAmountLeft;
    body = body +
        'Budget Name: ${_budget.budgetName}\n $spent spent of ${_budget.budgetAmount} ${_budget.selectedCurrency}\n$wantedBills Bills: \n';
    _bills.forEach((bill) {
      if (bill.reimbursable == trueOrFalse) {
        body = body +
            '    ${bill.date} ${bill.billName}: ${bill.billAmount}${_budget.selectedCurrency}, Payed with ${bill.paymentType}\n';
      }
    });
  }
}
