import 'package:flutter/material.dart';
import 'package:sqflite_crud_flutter/models/employee.dart';
import 'package:sqflite_crud_flutter/screens/add_employee.dart';
import 'package:sqflite_crud_flutter/screens/edit_employee.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Employee> employees = List.empty(growable: true);
  bool isLoading = false;

  @override
  void initState() {
    employees.add(Employee(empId: 1, empName: 'Estes', empDesignation: 'Roam', isMale: true));
    employees.add(Employee(empId: 2, empName: 'Vexana', empDesignation: 'Mage', isMale: false));
    employees.add(Employee(empId: 3, empName: 'Ixia', empDesignation: 'Marksman', isMale: false));
    employees.add(Employee(empId: 4, empName: 'Phoveious', empDesignation: 'Exp', isMale: true));
    employees.add(Employee(empId: 5, empName: 'Hayabusa', empDesignation: 'Jungle', isMale: true));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'SQFLite CRUD',
          style: TextStyle(
            color: Colors.white
          ),
        ),
        centerTitle: true,
      ),
      body: isLoading
      ? Center(child: CircularProgressIndicator())
      : ListView.builder(
          itemCount: employees.length,
          itemBuilder: (context,index) => Card(
            child: ListTile(
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>
                    EditEmployee(employee: employees[index],)
                  ),
                );
              },
              leading:CircleAvatar(
                backgroundColor:  employees[index].isMale ? Colors.blue[300] : Colors.pink[300],
                child: Icon(employees[index].isMale ? Icons.male : Icons.female, color: Colors.white),
              ),
              title: Text('${employees[index].empName} (${employees[index].empId})',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(employees[index].empDesignation),
              trailing: IconButton(
                onPressed: (){},
                icon: Icon(Icons.delete),
              ),
            ),
          ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddEmployee()));
        },
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}