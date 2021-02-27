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
      this.selectedCurrency});

  final int id;
  final String budgetName;
  final double budgetAmount;
  final double transportBudget;
  final double foodBudget;
  final double accomodationBudget;
  final double pastimeBudget;
  final double otherExpensesBudget;
  final String selectedCurrency;

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
    };
  }
}
