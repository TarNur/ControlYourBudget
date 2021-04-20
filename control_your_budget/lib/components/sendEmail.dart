import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:control_your_budget/constants.dart';
import 'package:control_your_budget/components/alert_box.dart';
import 'package:control_your_budget/budget_helper.dart';
import 'package:control_your_budget/models/budget.dart';

class EmailSender extends StatefulWidget {
  final int budgetID;

  EmailSender({this.budgetID});

  @override
  _EmailSenderState createState() => _EmailSenderState();
}

class _EmailSenderState extends State<EmailSender> {
  List<String> attachments = [];
  String body = 'Your Budget Report \n\n';

  final _recipientController = TextEditingController(
    text: 'reciepient@example.com',
  );

  final _subjectController = TextEditingController(text: 'Budget Report');

  final _bodyController = TextEditingController(
    text: 'Enter Email body.',
  );

  Future<void> send() async {
    createBody();
    final Email email = Email(
      body: body,
      subject: '${_budget.budgetName} Budget Report',
      recipients: [_recipientController.text],
      attachmentPaths: attachments,
    );

    String platformResponse;
    print(body);

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }

    print(platformResponse);
    showAlertDialogEmailResponse(context, platformResponse);
    if (!mounted) return;
  }

  BudgetHelper _budgetHelper = BudgetHelper();
  BudgetInfo _budget;
  List<BillInfo> _bills;
  List<BillInfo> transportBills = [];
  List<BillInfo> accomodationBills = [];
  List<BillInfo> foodBills = [];
  List<BillInfo> pastimeBills = [];
  List<BillInfo> otherBills = [];
  var budgetsMade = 0;

  @override
  void initState() {
    _budgetHelper.initializeDatabase().then((value) {
      loadBudget();
      print('-----------database initialized');
    });
    super.initState();
  }

  void loadBudget() async {
    _budget = await _budgetHelper.getBudget(widget.budgetID);
    _bills = await _budgetHelper.getSingleBudgetBills(widget.budgetID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Budget Report'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              send();
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.send,
              color: Colors.cyan,
            ),
          )
        ],
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
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
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
            Expanded(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: _bodyController,
                  style: kLabelTextStyle,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                      labelText: 'Body', border: OutlineInputBorder()),
                ),
              ),
            ),
          ],
        ),
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
        '${_budget.budgetName}\n $spent spent of ${_budget.budgetAmount} ${_budget.selectedCurrency}\nBills: \n';
    spent = _budget.transportBudget - _budget.transportBudgetLeft;
    body = body +
        ' Transport: $spent spent of ${_budget.transportBudget} ${_budget.selectedCurrency}\n';
    transportBills.forEach((bill) {
      reimbursableformat =
          bill.reimbursable == 1 ? 'Is reimbursable' : 'Not reimbursable';
      body = body +
          '   ${bill.date} ${bill.billName}: ${bill.billAmount}${_budget.selectedCurrency}, $reimbursableformat, Payed with ${bill.paymentType}\n';
    });
    spent = _budget.accomodationBudget - _budget.accomodationBudgetLeft;
    body = body +
        ' Accommodation: $spent spent of ${_budget.accomodationBudget} ${_budget.selectedCurrency}\n';
    accomodationBills.forEach((bill) {
      reimbursableformat =
          bill.reimbursable == 1 ? 'Is reimbursable' : 'Not reimbursable';
      body = body +
          '   ${bill.date} ${bill.billName}: ${bill.billAmount}${_budget.selectedCurrency}, $reimbursableformat, Payed with ${bill.paymentType}\n';
    });
    spent = _budget.foodBudget - _budget.foodBudgetLeft;
    body = body +
        ' Food: $spent spent of ${_budget.foodBudget} ${_budget.selectedCurrency}\n';
    foodBills.forEach((bill) {
      reimbursableformat =
          bill.reimbursable == 1 ? 'Is reimbursable' : 'Not reimbursable';
      body = body +
          '   ${bill.date} ${bill.billName}: ${bill.billAmount}${_budget.selectedCurrency}, $reimbursableformat, Payed with ${bill.paymentType}\n';
    });
    spent = _budget.pastimeBudget - _budget.pastimeBudgetLeft;
    body = body +
        ' Pastime: $spent spent of ${_budget.pastimeBudget} ${_budget.selectedCurrency}\n';
    pastimeBills.forEach((bill) {
      reimbursableformat =
          bill.reimbursable == 1 ? 'Is reimbursable' : 'Not reimbursable';
      body = body +
          '   ${bill.date} ${bill.billName}: ${bill.billAmount}${_budget.selectedCurrency}, $reimbursableformat, Payed with ${bill.paymentType}\n';
    });
    spent = _budget.otherExpensesBudget - _budget.otherExpensesBudgetLeft;
    body = body +
        ' Other: $spent spent of ${_budget.otherExpensesBudget} ${_budget.selectedCurrency}\n';
    otherBills.forEach((bill) {
      reimbursableformat =
          bill.reimbursable == 1 ? 'Is reimbursable' : 'Not reimbursable';
      body = body +
          '   ${bill.date} ${bill.billName}: ${bill.billAmount}${_budget.selectedCurrency}, $reimbursableformat, Payed with ${bill.paymentType}\n';
    });
  }
}
