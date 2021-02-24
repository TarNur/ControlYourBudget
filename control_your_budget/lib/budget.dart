class Budget {

  String username;
  String budgetName;
  double fullBudget;
  double transportBudget;
  double foodBudget;
  double accomodationBudget;
  double pastimeBudget;
  double otherExpensesBudget;

  Budget({double fB, String bN}){
    fullBudget=fB;
    budgetName=bN;
  }
}
