import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:control_your_budget/budget_helper.dart';
import 'package:control_your_budget/models/budget.dart';
import 'package:control_your_budget/constants.dart';
import 'package:control_your_budget/components/bottom_create_button.dart';
import 'package:control_your_budget/screens/edit_value_screen.dart';
import 'package:control_your_budget/screens/edit_text_value_screen.dart';
import 'package:control_your_budget/components/alert_box.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'dart:io' show Platform;
import 'dart:io';

class EditBill extends StatefulWidget {
  final BillInfo bill;
  final String selectedCurrency;

  EditBill({this.bill, this.selectedCurrency});

  @override
  _EditBillState createState() => _EditBillState();
}

class _EditBillState extends State<EditBill> {
  BudgetHelper _budgetHelper = BudgetHelper();
  int once = 0;
  File _image;
  Uint8List _bytesImage;
  String base64Image;
  String newPickedImage;
  DateTime selectedDate;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  final picker = ImagePicker();

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
        _bytesImage = Base64Decoder().convert(base64Image);
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
        _bytesImage = Base64Decoder().convert(base64Image);
        showAlertDialogImageUploaded(context);
      } else {
        print('didnt select an image');
      }
    });
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

  _saveImage() async {
    String result;
    try {
      await ImageGallerySaver.saveImage(Uint8List.fromList(_bytesImage),
          quality: 100, name: billName);
      result = 'Image Saved.';
    } catch (error) {
      result = error.toString();
    }
    showAlertDialogSaveImage(context, result);
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

  String fromSubcategoryFormat(String subCategory) {
    if (subCategory == 'transportBudget') {
      return 'Transport';
    } else if (subCategory == 'accomodationBudget') {
      return 'Accom.';
    } else if (subCategory == 'foodBudget') {
      return 'Food';
    } else if (subCategory == 'pastimeBudget') {
      return 'Pastime';
    } else {
      return 'Other';
    }
  }

  String billName;
  double billAmount;
  String paymentType;
  String subCategory;
  bool reimbursable;
  var descriptionController = TextEditingController(text: 'Bill Details: ');

  double prevBillAmount;

  @override
  Widget build(BuildContext context) {
    if (once == 0) {
      billName = widget.bill.billName;
      billAmount = widget.bill.billAmount;
      prevBillAmount = widget.bill.billAmount;
      paymentType = widget.bill.paymentType;
      subCategory = widget.bill.billSubcategory;
      subCategory = fromSubcategoryFormat(subCategory);
      reimbursable = widget.bill.reimbursable == 0 ? false : true;
      selectedDate = dateFormat.parse(widget.bill.date);
      if (widget.bill.description != null) {
        descriptionController.text = widget.bill.description;
      } 
      if (widget.bill.image != null) {
        base64Image = widget.bill.image;
        _bytesImage = Base64Decoder().convert(base64Image);
      } else {
        _bytesImage = null;
      }
    }
    once = 1;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('CONTROL YOUR BUDGET'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Bill NAME SISESTUS
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
                    'Bill Amount: $billAmount ${widget.selectedCurrency}',
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
                          billAmount = double.parse(billAmount.toStringAsFixed(2));
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Your Payment Type: $paymentType',
                    style: kLabelTextStyle,
                  ),
                  Container(
                    height: 40.0,
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 0),
                    color: Colors.white,
                    child: Platform.isIOS ? iOSPicker2() : androidDropdown2(),
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
                                return Colors.cyan;
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
                                  child: _bytesImage == null
                                      ? Text(
                                          'No Image Selected',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              height: 20.0,
                                              color: kLightGreyColour),
                                        )
                                      : Image.memory(
                                          _bytesImage,
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
                                return Colors.cyan;
                              },
                            ),
                          ),
                          child: Text('Bill Descr.'),
                          onPressed: () {
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: double.infinity,
                                  margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
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
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              return Colors.cyan;
                            },
                          ),
                        ),
                        onPressed: () {
                          if (_bytesImage != null) {
                            _saveImage();
                          } else {
                            showAlertDialogSaveImage(
                                context, 'No Image to Save');
                          }
                        },
                        child: Text('Save Image'),
                      ),
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
              var updatedBill = BillInfo(
                billID: widget.bill.billID,
                billName: billName,
                billAmount: billAmount,
                id: widget.bill.id,
                billSubcategory: correctSubcategory,
                paymentType: paymentType,
                reimbursable: ifReimbursable,
                image: base64Image,
                date: dateForDatabase,
                description: descriptionController.text,
              );
              if (billAmount <= 0) {
                showAlertDialogBillAmount0(context);
              } else if (billName == null || billName == '') {
                showAlertDialogBillNameNullAfterEdit(context);
              } else {
                BudgetInfo currentBudget =
                    await _budgetHelper.getBudget(widget.bill.id);
                _budgetHelper.updateBudgetAmountsLeft(widget.bill.id,
                    subCategory, currentBudget, double.parse((billAmount - prevBillAmount).toStringAsFixed(2)));
                _budgetHelper.updateBill(updatedBill);
                Navigator.pop(context);
              }
            },
            buttonTitle: 'SAVE',
          )
        ],
      ),
    );
  }
}
