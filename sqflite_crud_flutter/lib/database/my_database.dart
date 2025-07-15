import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_crud_flutter/models/employee.dart';

class MyDatabase {
  // Singleton instance of the database class
  static final MyDatabase _myDatabase = MyDatabase._privateConstructor();

  // Private named constructor for singleton implementation
  MyDatabase._privateConstructor();

  // Factory constructor that returns the singleton instance
  factory MyDatabase() {
    return _myDatabase;
  }

  // SQLite database instance (nullable until initialized)
  static Database? _database;

  // Table and column definitions
  final String tableName = 'emp';
  final String columnId = 'id';
  final String columnName = 'name';
  final String columnDesignation = 'desg';
  final String columnIsMale = 'isMale';

  // Getter that ensures the database is initialized before use
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initializeDatabase();
    return _database!;
  }

  // Initializes and opens the SQLite database, creating it if it doesn't exist
  Future<Database> _initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/emp.db';

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableName (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT,
            $columnDesignation TEXT,
            $columnIsMale BOOLEAN
          )
        ''');
      },
    );
  }

  // Fetches all employee records from the database, sorted by name
  Future<List<Map<String, Object?>>> getEmpList() async {
    final db = await database;
    return await db.query(tableName, orderBy: columnName);
  }

  // Inserts a new employee record into the database
  Future<int> insertEmp(Employee employee) async {
    final db = await database;
    return await db.insert(tableName, employee.toMap());
  }

  // Updates an existing employee record based on the employee ID
  Future<int> updateEmp(Employee employee) async {
    final db = await database;
    return await db.update(
      tableName,
      employee.toMap(),
      where: '$columnId = ?',
      whereArgs: [employee.empId],
    );
  }

  // Deletes an employee record from the database by ID
  Future<int> deleteEmp(Employee employee) async {
    final db = await database;
    return await db.delete(
      tableName,
      where: '$columnId = ?',
      whereArgs: [employee.empId],
    );
  }

  // Returns the total number of employee records in the table
  Future<int> countEmp() async {
    final db = await database;
    List<Map<String, Object?>> result =
        await db.rawQuery('SELECT COUNT(*) FROM $tableName');
    return Sqflite.firstIntValue(result) ?? 0;
  }
}
