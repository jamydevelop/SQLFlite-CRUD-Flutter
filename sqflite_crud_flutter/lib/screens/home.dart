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
    employees.add(Employee(id: 1, name: 'Estes', desg: 'Roam', isMale: true));
    employees.add(Employee(id: 2, name: 'Vexana', desg: 'Mage', isMale: false));
    employees.add(Employee(id: 3, name: 'Ixia', desg: 'Marksman', isMale: false));
    employees.add(Employee(id: 4, name: 'Phoveious', desg: 'Exp', isMale: true));
    employees.add(Employee(id: 5, name: 'Hayabusa', desg: 'Jungle', isMale: true));
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
              title: Text('${employees[index].name} (${employees[index].id})',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(employees[index].desg),
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