import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:control_your_budget/budget_helper.dart';
import 'package:control_your_budget/models/budget.dart';
import 'package:control_your_budget/constants.dart';
import 'package:control_your_budget/components/bottom_create_button.dart';
import 'package:control_your_budget/screens/edit_value_screen.dart';
import 'package:control_your_budget/screens/edit_text_value_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:control_your_budget/components/alert_box.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'dart:io' show Platform;

class NewBill extends StatefulWidget {
  final int budgetID;
  final String selectedCurrency;

  NewBill({this.budgetID, this.selectedCurrency});

  @override
  _NewBillState createState() => _NewBillState();
}

class _NewBillState extends State<NewBill> {
  BudgetHelper _budgetHelper = BudgetHelper();
  File _image;
  String base64Image;
  final picker = ImagePicker();
  DateTime selectedDate = DateTime.now();
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  Future getImagefromcamera() async {
    final pickedImage = await picker.getImage(
      source: ImageSource.camera,
      maxHeight: 500.0,
      maxWidth: 500.0,
    );
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
        List<int> imageBytes = _image.readAsBytesSync();
        base64Image = base64Encode(imageBytes);
        showAlertDialogImageUploaded(context);
      } else {
        print('didnt select an image');
      }
    });
  }

  Future getImagefromGallery() async {
    final pickedImage = await picker.getImage(
      source: ImageSource.gallery,
      maxHeight: 500.0,
      maxWidth: 500.0,
    );
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
        List<int> imageBytes = _image.readAsBytesSync();
        base64Image = base64Encode(imageBytes);
        showAlertDialogImageUploaded(context);
      } else {
        print('didnt select an image');
      }
    });
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String subCategory in subCategories) {
      var newItem = DropdownMenuItem(
        child: Text(subCategory),
        value: subCategory,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: subCategory,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          subCategory = value;
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String subCategory in subCategories) {
      pickerItems.add(Text(subCategory));
    }

    return CupertinoPicker(
      backgroundColor: Colors.white,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          subCategory = subCategories[selectedIndex];
        });
      },
      children: pickerItems,
    );
  }

  DropdownButton<String> androidDropdown2() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String paymentType in paymentTypes) {
      var newItem = DropdownMenuItem(
        child: Text(paymentType),
        value: paymentType,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: paymentType,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          paymentType = value;
        });
      },
    );
  }

  CupertinoPicker iOSPicker2() {
    List<Text> pickerItems = [];
    for (String paymentType in paymentTypes) {
      pickerItems.add(Text(paymentType));
    }

    return CupertinoPicker(
      backgroundColor: Colors.white,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          paymentType = paymentTypes[selectedIndex];
        });
      },
      children: pickerItems,
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  String getSubcategoryFormat(String subCategory) {
    String correctFormatSubcategory;
    if (subCategory == 'Transport') {
      correctFormatSubcategory = 'transportBudget';
    } else if (subCategory == 'Accom.') {
      correctFormatSubcategory = 'accomodationBudget';
    } else if (subCategory == 'Food') {
      correctFormatSubcategory = 'foodBudget';
    } else if (subCategory == 'Pastime') {
      correctFormatSubcategory = 'pastimeBudget';
    } else {
      correctFormatSubcategory = 'otherExpensesBudget';
    }
    return correctFormatSubcategory;
  }

  String billName = 'Enter Bill Name';
  int budgetID;
  double billAmount = 0;
  String paymentType = 'Credit';
  String subCategory = 'Transport';
  String description = 'Description';
  var descriptionController = TextEditingController(
    text: 'Bill Details: ',
  );
  String selectedCurrency;
  bool ifBudgetNameChanged = false;
  bool reimbursable = false;

  @override
  Widget build(BuildContext context) {
    budgetID = widget.budgetID;
    selectedCurrency = widget.selectedCurrency;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Bill Name: $billName',
                    style: kLabelTextStyle,
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    iconSize: 30.0,
                    color: Colors.cyan,
                    onPressed: () async {
                      var typedValue = await showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: EditTextValueScreen(),
                          ),
                        ),
                      );
                      if (typedValue != null) {
                        setState(() {
                          billName = typedValue;
                          ifBudgetNameChanged = true;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          // BUDGET AMOUNT SISESTUS
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Bill Amount: $billAmount $selectedCurrency',
                    style: kLabelTextStyle,
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    iconSize: 30.0,
                    color: Colors.cyan,
                    onPressed: () async {
                      var typedValue = await showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: EditValueScreen(),
                          ),
                        ),
                      );
                      if (typedValue != null) {
                        setState(() {
                          billAmount = double.parse(typedValue);
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Bill type: ',
                            style: kLabelTextStyle,
                          ),
                          Container(
                            height: 40.0,
                            width: 150.0,
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            color: Colors.white,
                            child: Platform.isIOS
                                ? iOSPicker()
                                : androidDropdown(),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Payment Type: ',
                            style: kLabelTextStyle,
                          ),
                          Container(
                            height: 40.0,
                            width: 150.0,
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: 0),
                            color: Colors.white,
                            child: Platform.isIOS
                                ? iOSPicker2()
                                : androidDropdown2(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Reimbursable?',
                            style: kLabelTextStyle,
                          ),
                          Checkbox(
                              value: reimbursable,
                              activeColor: Colors.cyan,
                              onChanged: (value) {
                                setState(() {
                                  reimbursable = !reimbursable;
                                });
                              })
                        ],
                      ),
                      Text(
                        "Selected Date: ${dateFormat.format(selectedDate)}",
                        style: kLabelTextStyle,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                return Colors
                                    .cyan; // Use the component's default.
                              },
                            ),
                          ),
                          child: Text('View Image'),
                          onPressed: () {
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: double.infinity,
                                  color: kActiveCardColour,
                                  child: _image == null
                                      ? Text(
                                          'No Image Selected',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              height: 20.0,
                                              color: kLightGreyColour),
                                        )
                                      : Image.file(
                                          _image,
                                          fit: BoxFit.contain,
                                        ),
                                );
                              },
                            );
                          }),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              return Colors.cyan;
                            },
                          ),
                        ),
                        onPressed: () => _selectDate(context),
                        child: Text('Select date'),
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                return Colors
                                    .cyan; 
                              },
                            ),
                          ),
                          child: Text('Bill Descr.'),
                          onPressed: () {
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                                  height: double.infinity,
                                  color: Colors.white,
                                  child: TextField(
                                    controller: descriptionController,
                                    style: kLabelTextStyle,
                                    maxLines: null,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Bill Description',
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          iconSize: 40.0,
                          icon: Icon(Icons.camera_alt),
                          onPressed: getImagefromcamera,
                          color: Colors.cyan),
                      IconButton(
                          iconSize: 40.0,
                          icon: Icon(Icons.folder),
                          onPressed: getImagefromGallery,
                          color: Colors.cyan),
                    ],
                  ),
                ],
              ),
            ),
          ),

          BottomButton(
            // CREATE BUDGET NUPP
            onTap: () async {
              int ifReimbursable = reimbursable ? 1 : 0;
              String correctSubcategory = getSubcategoryFormat(subCategory);
              String dateForDatabase = dateFormat.format(selectedDate);
              print(dateForDatabase);
              var billInfo = BillInfo(
                billName: billName,
                billAmount: billAmount,
                id: budgetID,
                billSubcategory: correctSubcategory,
                paymentType: paymentType,
                reimbursable: ifReimbursable,
                image: base64Image,
                date: dateForDatabase,
                description: descriptionController.text,
              );
              if (billAmount <= 0) {
                showAlertDialogBillAmount0(context);
              } else if (ifBudgetNameChanged == false ||
                  billName == null ||
                  billName == '') {
                showAlertDialogBillName(context);
              } else {
                BudgetInfo currentBudget =
                    await _budgetHelper.getBudget(budgetID);
                _budgetHelper.updateBudgetAmountsLeft(
                    budgetID, subCategory, currentBudget, billAmount);
                currentBudget = await _budgetHelper.getBudget(budgetID);
                _budgetHelper.insertBill(billInfo);
                Navigator.pop(context);
              }
            },
            buttonTitle: 'CREATE BILL',
          )
        ],
      ),
    );
  }
}
