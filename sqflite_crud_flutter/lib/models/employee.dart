// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

Employee toEmployee(Map<String, Object?> map) => Employee.toEmp(map);

class Employee {
  final int empId;
  final String empName;
  final String empDesignation;
  final bool isMale;

  Employee({
    required this.empId,
    required this.empName,
    required this.empDesignation,
    required this.isMale});

  //convert to map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': empId,
      'name': empName,
      'desg': empDesignation,
      'isMale': isMale,
    };
  }

  //convert Map to Employee
  factory  Employee.toEmp(Map<String, dynamic> map) => Employee(
    empId: map['id'],
    empName: map['name'],
    empDesignation: map['desg'],
    isMale: map['isMale'] == 1 ? true : false);

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      empId: map['empId'] as int,
      empName: map['empName'] as String,
      empDesignation: map['empDesignation'] as String,
      isMale: map['isMale'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Employee.fromJson(String source) => Employee.fromMap(json.decode(source) as Map<String, dynamic>);
}
