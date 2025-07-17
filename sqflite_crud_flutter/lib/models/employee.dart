// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

Employee toEmployee(Map<String, Object?> map) => Employee.toEmp(map);

class Employee {
  final int id;
  final String name;
  final String desg;
  final bool isMale;

  Employee({
    required this.id,
    required this.name,
    required this.desg,
    required this.isMale});

  //convert to map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'desg': desg,
      'isMale': isMale,
    };
  }

  //convert Map to Employee
  factory  Employee.toEmp(Map<String, dynamic> map) => Employee(
    id: map['id'],
    name: map['name'],
    desg: map['desg'],
    isMale: map['isMale'] == 1 ? true : false);

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'] as int,
      name: map['name'] as String,
      desg: map['desg'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Employee.fromJson(String source) => Employee.fromMap(json.decode(source) as Map<String, dynamic>);
}
