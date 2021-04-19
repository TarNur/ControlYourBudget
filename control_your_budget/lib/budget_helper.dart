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
final String billID = 'billID';
final String billName = 'billName';
final String billAmount = 'billAmount';
final String paymentType = 'paymentType';
final String reimbursable = 'reimbursable';
final String image = 'image';
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
    var path = p.join(dir, 'controlyourbudgetapp.db');

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
          $billID integer primary key autoincrement,
          $budgetID integer,
          $billSubcategory text not null,
          $billName text not null,
          $billAmount real,
          $paymentType text not null,
          $reimbursable integer,
          $image text)
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

  void insertBill(BillInfo billInfo) async {
    var db = await this.database;
    var result = await db.insert(
      tableName2,
      billInfo.toMap(),
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

  Future<List<BillInfo>> getBills() async {
    List<BillInfo> _bills = [];

    var db = await this.database;
    var result = await db.query(tableName2);
    result.forEach((element) {
      var billInfo = BillInfo.fromMap(element);
      _bills.add(billInfo);
    });

    return _bills;
  }

  Future<List<BillInfo>> getSingleSubCategoryBills(
      int id, String subCategory) async {
    List<BillInfo> _bills = [];

    var db = await this.database;
    var result = await db.rawQuery(
        'SELECT * FROM $tableName2 WHERE id=? AND billSubcategory=?',
        [id, subCategory]);
    result.forEach((element) {
      var billInfo = BillInfo.fromMap(element);
      _bills.add(billInfo);
    });

    return _bills;
  }

  Future<BudgetInfo> getBudget(int id) async {
    // muuta
    final db = await this.database;

    List<Map> result =
        await db.rawQuery('SELECT * FROM $tableName WHERE id=?', [id]);

    return BudgetInfo.fromMap(result.first);
  }

  Future<BillInfo> getBill(int billID) async {
    // muuta
    final db = await this.database;

    List<Map> result =
        await db.rawQuery('SELECT * FROM $tableName2 WHERE billID=?', [billID]);

    return BillInfo.fromMap(result.first);
  }

  Future<void> updateBudgetAmountsLeft(
      int id, String subCategory, BudgetInfo budget, double billAmount) async {
    final db = await this.database;

    double budgetAmountLeftCurrent = budget.budgetAmountLeft;
    double subcategoryLeftCurrent;
    if (subCategory == 'Transport') {
      subcategoryLeftCurrent = budget.transportBudgetLeft;
      await db.rawUpdate(
          'UPDATE $tableName SET $transportBudgetLeft = ? WHERE id = ?',
          [subcategoryLeftCurrent - billAmount, id]);
    } else if (subCategory == 'Accommodation') {
      subcategoryLeftCurrent = budget.accomodationBudgetLeft;
      await db.rawUpdate(
          'UPDATE $tableName SET $accomodationBudgetLeft = ? WHERE id = ?',
          [subcategoryLeftCurrent - billAmount, id]);
    } else if (subCategory == 'Food') {
      subcategoryLeftCurrent = budget.foodBudgetLeft;
      await db.rawUpdate(
          'UPDATE $tableName SET $foodBudgetLeft = ? WHERE id = ?',
          [subcategoryLeftCurrent - billAmount, id]);
    } else if (subCategory == 'Pastime') {
      subcategoryLeftCurrent = budget.pastimeBudgetLeft;
      await db.rawUpdate(
          'UPDATE $tableName SET $pastimeBudgetLeft = ? WHERE id = ?',
          [subcategoryLeftCurrent - billAmount, id]);
    } else {
      subcategoryLeftCurrent = budget.otherExpensesBudgetLeft;
      await db.rawUpdate(
          'UPDATE $tableName SET $otherExpensesBudgetLeft = ? WHERE id = ?',
          [subcategoryLeftCurrent - billAmount, id]);
    }
    await db.rawUpdate(
        'UPDATE $tableName SET $budgetAmountLeft = ? WHERE id = ?',
        [budgetAmountLeftCurrent - billAmount, id]);
  }

  Future<void> updateBudget(BudgetInfo updatedBudget) async {
    final db = await this.database;

    await db.update(
      'budget',
      updatedBudget.toMap(),
      where: "id = ?",
      whereArgs: [updatedBudget.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateBill(BillInfo updatedBill) async {
    final db = await this.database;

    await db.update(
      'bill',
      updatedBill.toMap(),
      where: "billID = ?",
      whereArgs: [updatedBill.billID],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteBudget(int id) async {
    final db = await this.database;

    await db.delete(
      'budget',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteBill(int billID) async {
    final db = await this.database;

    await db.delete(
      'bill',
      where: "billID = ?",
      whereArgs: [billID],
    );
  }

  Future<void> deleteAllBillsFromBudget(int budgetID) async {
    final db = await this.database;

    await db.delete(
      'bill',
      where: "id = ?",
      whereArgs: [budgetID],
    );
  }
}
