import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_crud_flutter/models/employee.dart';

class MyDatabase {

  //Instance of database
  static final MyDatabase _myDatabase = MyDatabase._privateConstructor();

  // Private Contructor
  MyDatabase._privateConstructor();

  //Database Variable
  static late Database _database;

  //factory method
  factory MyDatabase() {
    return _myDatabase;
  }

  //Variables for column
  final String tableName = 'emp';
  final String columnId = 'empId';
  final String columnName = 'name';
  final String columnDesignation ='designation';
  final String columnIsMale = 'isMale';

  //function to initialize database
  initializeDatabase() async {

    //Get the path of file system where to store database.
    Directory directory = await getApplicationDocumentsDirectory();

    //Path
    String path = '${directory.path}emp.db';

    //Create database
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db,version) async {
      await db.execute('CREATE TABLE $tableName ($columnId INTEGER PRIMARY KEY, $columnName TEXT, $columnDesignation TEXT, $columnIsMale BOOLEAN)');
    });
  }

  //------ CRUDE -----------

  //**READ DATA**
  Future<List<Map<String, Object?>>> getEmpList() async {

    //1st way
    //List<Map<String, Object?>> result = await _database.rawQuery('SELECT * FROM $tableName');

    //2nd way
    List<Map<String, Object?>> result =
    await _database.query(tableName, orderBy: columnName);

    return result;
  }

  //**INSERT DATA**
  Future<int> insertEmp(Employee employee) async {

    int rowsInserted = await _database.insert(tableName, employee.toMap());

    return rowsInserted;
  }

    //**Update DATA**
  Future<int> updateEmp(Employee employee) async {

    int updateInserted = await _database.update(tableName, employee.toMap(), where: '$columnId = ?', whereArgs: [employee.empId]);

    return updateInserted;
  }

    //**Delete DATA**
  Future<int> deleteEmp(Employee employee) async {

    int deleteInserted = await _database
      .delete(tableName, where: '$columnId = ?', whereArgs: [employee.empId]);

    return deleteInserted;
  }

  //**COUNT METHOD **
  Future<int> countEmp() async {
    List<Map<String, Object?>> result =
      await _database.rawQuery('SELECT COUNT(*) FROM ${tableName}');

      int count = Sqflite.firstIntValue(result) ?? 0;

      return count;
  }


}