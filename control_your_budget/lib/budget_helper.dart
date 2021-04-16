import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:control_your_budget/models/budget.dart';
import 'package:path/path.dart' as p;

final String tableName = 'budget';
final String budgetID = 'id';
final String budgetName = 'budgetName';
final String budgetAmount = 'budgetAmount';
final String transportBudget = 'transportBudget';
final String accomodationBudget = 'accomodationBudget';
final String foodBudget = 'foodBudget';
final String pastimeBudget = 'pastimeBudget';
final String otherExpensesBudget = 'otherExpensesBudget';
final String selectedCurrency = 'selectedCurrency';

final String tableName2 = 'bill';
final String billName = 'billName';
final String billAmount = 'billAmount';
final String paymentType = 'paymentType';
final String reimbursable = 'reimbursable';
final String billSubcategory = 'billSubcategory';

final String budgetAmountLeft = 'budgetAmountLeft';
final String transportBudgetLeft = 'transportBudgetLeft';
final String accomodationBudgetLeft = 'accomodationBudgetLeft';
final String foodBudgetLeft = 'foodBudgetLeft';
final String pastimeBudgetLeft = 'pastimeBudgetLeft';
final String otherExpensesBudgetLeft = 'otherExpensesBudgetLeft';
final String selectedCurrencyLeft = 'selectedCurrencyLeft';

class BudgetHelper {
  static Database _database;
  static BudgetHelper _budgetHelper;

  BudgetHelper._createInstance();
  factory BudgetHelper() {
    if (_budgetHelper == null) {
      _budgetHelper = BudgetHelper._createInstance();
    }
    return _budgetHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    //var path = dir + "budgets.db";
    var path = p.join(dir, 'budget.db');

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
        create table $tableName (
          $budgetID integer primary key autoincrement,
          $budgetName text not null,
          $budgetAmount real,
          $transportBudget real,
          $accomodationBudget real,
          $foodBudget real,
          $pastimeBudget real,
          $otherExpensesBudget real,
          $selectedCurrency text not null,
          $budgetAmountLeft real,
          $transportBudgetLeft real,
          $accomodationBudgetLeft real,
          $foodBudgetLeft real,
          $pastimeBudgetLeft real,
          $otherExpensesBudgetLeft real)
        ''');
        db.execute('''
        create table $tableName2 (
          $budgetID integer primary key,
          $billSubcategory text not null
          $billName text not null,
          $billAmount real,
          $paymentType text not null,
          $reimbursable numeric)
        ''');
      },
    );
    return database;
  }

  void insertBudget(BudgetInfo budgetInfo) async {
    var db = await this.database;
    var result = await db.insert(
      tableName,
      budgetInfo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('result $result');
  }

  Future<List<BudgetInfo>> getBudgets() async {
    List<BudgetInfo> _budgets = [];

    var db = await this.database;
    var result = await db.query(tableName);
    result.forEach((element) {
      var budgetInfo = BudgetInfo.fromMap(element);
      _budgets.add(budgetInfo);
    });

    return _budgets;
  }

  Future<void> deleteBudget(int id) async {
  final db = await database;


  await db.delete(
    'budget',
    where: "id = ?",
    whereArgs: [id],
  );
}
}
