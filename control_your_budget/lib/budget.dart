class Budget{
  
  Budget({this.budgetName,this.fullBudgetAmount});

  final String budgetName;
  final double fullBudgetAmount;
  
  void printData(){
    print('Budgeti nimi on $budgetName');
    print('Budgeti full amount on $fullBudgetAmount');
  }
}