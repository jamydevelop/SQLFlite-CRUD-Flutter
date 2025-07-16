import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

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

  Future<Database> _initDatabase() async {

    String directory = await getDatabasesPath();
    String path = join(directory, 'emp.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db,version) async {
        await db.execute(
          '''
          CREATE TABLE $tableName (
              $columnId
            )
          '''
        );
      }
    );

  }

}