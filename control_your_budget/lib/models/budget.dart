
class BudgetInfo {
  BudgetInfo(
      {this.id,
      this.budgetName,
      this.budgetAmount,
      this.transportBudget,
      this.foodBudget,
      this.accomodationBudget,
      this.pastimeBudget,
      this.otherExpensesBudget,
      this.selectedCurrency,
      this.budgetAmountLeft,
      this.transportBudgetLeft,
      this.foodBudgetLeft,
      this.accomodationBudgetLeft,
      this.pastimeBudgetLeft,
      this.otherExpensesBudgetLeft});

  final int id;
  final String budgetName;
  final double budgetAmount;
  final double transportBudget;
  final double foodBudget;
  final double accomodationBudget;
  final double pastimeBudget;
  final double otherExpensesBudget;
  final String selectedCurrency;
  final double budgetAmountLeft;
  final double transportBudgetLeft;
  final double foodBudgetLeft;
  final double accomodationBudgetLeft;
  final double pastimeBudgetLeft;
  final double otherExpensesBudgetLeft;

  void changeBudgetAmount() {}

  void changeBudgetName() {}

  factory BudgetInfo.fromMap(Map<String, dynamic> json) => BudgetInfo(
        id: json["id"],
        budgetName: json["budgetName"],
        budgetAmount: json["budgetAmount"].toDouble(),
        transportBudget: json["transportBudget"].toDouble(),
        foodBudget: json["foodBudget"].toDouble(),
        accomodationBudget: json["accomodationBudget"].toDouble(),
        pastimeBudget: json["pastimeBudget"].toDouble(),
        otherExpensesBudget: json["otherExpensesBudget"].toDouble(),
        selectedCurrency: json["selectedCurrency"],
        budgetAmountLeft: json["budgetAmountLeft"].toDouble(),
        transportBudgetLeft: json["transportBudgetLeft"].toDouble(),
        foodBudgetLeft: json["foodBudgetLeft"].toDouble(),
        accomodationBudgetLeft: json["accomodationBudgetLeft"].toDouble(),
        pastimeBudgetLeft: json["pastimeBudgetLeft"].toDouble(),
        otherExpensesBudgetLeft: json["otherExpensesBudgetLeft"].toDouble(),
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'budgetName': budgetName,
      'budgetAmount': budgetAmount,
      'transportBudget': transportBudget,
      'foodBudget': foodBudget,
      'accomodationBudget': accomodationBudget,
      'pastimeBudget': pastimeBudget,
      'otherExpensesBudget': otherExpensesBudget,
      'selectedCurrency': selectedCurrency,
      'budgetAmountLeft': budgetAmountLeft,
      'transportBudgetLeft': transportBudgetLeft,
      'foodBudgetLeft': foodBudgetLeft,
      'accomodationBudgetLeft': accomodationBudgetLeft,
      'pastimeBudgetLeft': pastimeBudgetLeft,
      'otherExpensesBudgetLeft': otherExpensesBudgetLeft,
    };
  }
}

class BillInfo {
  BillInfo(
      {this.billID,
      this.id,
      this.billName,
      this.billAmount,
      this.billSubcategory,
      this.paymentType,
      this.reimbursable,
      this.image});

  final int billID;
  final int id;
  final String billName;
  final double billAmount;
  final String billSubcategory;
  final String paymentType;
  final int reimbursable;
  final String image;

  void changeBudgetAmount() {}

  void changeBudgetName() {}

  factory BillInfo.fromMap(Map<String, dynamic> json) => BillInfo(
        billID: json["billID"],
        id: json["id"],
        billName: json["billName"],
        billAmount: json["billAmount"].toDouble(),
        billSubcategory: json["billSubcategory"],
        paymentType: json["paymentType"],
        reimbursable: json["reimbursable"],
        image: json["image"],
      );

  Map<String, dynamic> toMap() {
    return {
      'billID': billID,
      'id': id,
      'billName': billName,
      'billAmount': billAmount,
      'billSubcategory': billSubcategory,
      'paymentType': paymentType,
      'reimbursable': reimbursable,
      'image': image,
    };
  }
}
