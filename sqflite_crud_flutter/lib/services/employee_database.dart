import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_crud_flutter/models/employee.dart';

class EmployeeDatabase {

  // Singleton instance
  static final EmployeeDatabase _empDatabase = EmployeeDatabase._pricateConstructor();

  //Private constructor
  EmployeeDatabase._pricateConstructor();

  //factory constructor that returns singleton object/instance.
  factory EmployeeDatabase() => _empDatabase;

  //SQLite database instance (nullable until initialize)
  static Database? _database;

  //define table and column names
  String tableName = 'emp';
  String columnId = 'id';
  String columnName = 'name';
  String columnDesg = 'desg';
  String columnIsMale = 'isMale';

  //Getter that ensures the database is initialized before use.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  //Initialize and open the SQLite database, creating if it doesn't exist.
  Future<Database> _initDatabase() async {
    String directory = await getDatabasesPath();
    String path = join(directory, 'emp.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db,version) async {
        await db.execute('''
          CREATE TABLE $tableName (
              $columnId INTEGER PRIMARY KEY,
              $columnName TEXT,
              $columnDesg TEXT,
              $columnIsMale BOOLEAN
          )
        ''');
      }
    );
  }

  //Fetch all employees from the database sorted by names.
  Future<List<Map<String,Object?>>> getAllEmpList() async {
    final db = await database;
    return db.query(tableName, orderBy: columnName);
  }

  //Insert employee to the database.
  Future<int> insertEmp(Employee employee) async {
    final db = await database;
    return await db.insert(tableName, employee.toMap());
  }

  Future<int> updateEmp(Employee emp) async {
    final db = await database;
    return await db.update(
      tableName,
      emp.toMap(),
      where: '$columnId = ?',
      whereArgs: [emp.id]
    );
  }

}