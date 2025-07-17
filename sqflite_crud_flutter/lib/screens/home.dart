import 'package:flutter/material.dart';
import 'package:sqflite_crud_flutter/database/my_database.dart';
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

  //Create instance of Database
  final MyDatabase _myDatabase = MyDatabase();
  int count = 0;

  //Get data from database
  getDataFromDb() async {

    //get a Map of data using "_myDatabase" object.
    List<Map<String, Object?>> map = await _myDatabase.getEmpList();

    /**
     *  Get all the data from map and convert it to Employee model,
     *  before it adds on the list
     */
    for(int i = 0; i < map.length; i++) {
      employees.add(Employee.toEmp(map[i]));
    }

    //This will get the total count of data that's in the database and pass it in variable.
    count = await _myDatabase.countEmp();

    //This will make the loading stop.
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // employees.add(Employee(empId: 1, empName: 'Estes', empDesignation: 'Roam', isMale: true));
    // employees.add(Employee(empId: 2, empName: 'Vexana', empDesignation: 'Mage', isMale: false));
    // employees.add(Employee(empId: 3, empName: 'Ixia', empDesignation: 'Marksman', isMale: false));
    // employees.add(Employee(empId: 4, empName: 'Phoveious', empDesignation: 'Exp', isMale: true));
    // employees.add(Employee(empId: 5, empName: 'Hayabusa', empDesignation: 'Jungle', isMale: true));
    getDataFromDb();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Employee\'s Count: $count',
          style: TextStyle(
            color: Colors.white
          ),
        ),
        centerTitle: true,
      ),
      body: isLoading
      ? Center(child: CircularProgressIndicator())
      : employees.isEmpty ? Center(child: Text('No Employee yet...'))
      : ListView.builder(
          itemCount: employees.length,
          itemBuilder: (context,index) => Card(
            child: ListTile(
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>
                    EditEmployee(employee: employees[index], mydatabase: _myDatabase)
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
                onPressed: () async {

                  String name = employees[index].empName;

                  await _myDatabase.deleteEmp(employees[index]);


                  if(mounted) {

                              //Show snackbar if added.
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                content: Text('$name is deleted!')));

                              //Navigate to previous route.
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Home(),
                                ),
                                (route) => false);
                            }
                },
                icon: Icon(Icons.delete),
              ),
            ),
          ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddEmployee(myDatabase: _myDatabase)));
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