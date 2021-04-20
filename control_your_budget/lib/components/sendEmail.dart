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
  String body = '';

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
      String reimbursableformat = bill.reimbursable == 1 ? 'Is reimbursable' : 'Not reimbursable';
      body = body + '${bill.date} ${bill.billName}: ${bill.billAmount}${_budget.selectedCurrency}, $reimbursableformat, Payed with ${bill.paymentType}\n';
    });
  }
}
