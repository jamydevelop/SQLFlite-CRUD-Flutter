import 'package:flutter/material.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {

  bool isFemale = false;

  //Controllers for text fields.
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController designationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          'Add Employee',
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              // Emp Id
              TextField(
                controller: idController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Employee Id',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Employee Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: designationController,
                decoration: InputDecoration(
                  hintText: 'Employee Designation',
                  border: OutlineInputBorder(),
                ),
              ),
              Row(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'Male',
                        style: TextStyle(
                          fontWeight: isFemale ? FontWeight.normal : FontWeight.bold,
                          color: isFemale ? Colors.pink : Colors.blue
                        ),
                      ),
                      Icon(Icons.male, color: isFemale ? Colors.pink : Colors.blue),
                    ],
                  ),
                  Switch(
                    value: isFemale,
                    onChanged: (newValue) {
                      setState(() {
                        isFemale = newValue;
                      });
                    }
                  ),
                ],
              )
              // Emp Name
              // Emp Designation
              // Emp Gender
            ],
          ),
        ),
      ),
    );
  }
}