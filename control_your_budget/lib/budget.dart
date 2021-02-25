class Budget{
  
  Budget({this.budgetName,this.fullBudgetAmount});

  final String budgetName;
  final double fullBudgetAmount;
  
  void printData(){
    print(budgetName);
    print(fullBudgetAmount);
  }
}