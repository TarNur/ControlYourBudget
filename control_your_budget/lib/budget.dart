class Budget {

  String username;
  String budgetName;
  double fullBudget;
  double foodBudget;
  double transportBudget;
  double accomodationBudget;

  Budget({double fB, double fB2}){
    fullBudget=fB;
    foodBudget=fB2;
  }
}

class CreateBudget{
  double transportBudget;
  double foodBudget;
  double accomodationBudget;
  double pastimeBudget;
  double otherExpensesBudget;

  CreateBudget({double fullBudget}){
    transportBudget = fullBudget * 0.3;
  }
}