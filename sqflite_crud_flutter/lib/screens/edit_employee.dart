import 'package:flutter/material.dart';
import 'package:sqflite_crud_flutter/models/employee.dart';

class EditEmployee extends StatefulWidget {
  final Employee employee;
  const EditEmployee({super.key, required this.employee});

  @override
  State<EditEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<EditEmployee> {
  //for switch() widget
  bool isFemale = false;

  //focusNode
  final FocusNode _focusNode = FocusNode();

  //Controllers for text fields.
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController designationController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    //Pass the data on CONTROLLERS from Navigation.
    idController.text = '${widget.employee.id}';
    nameController.text = widget.employee.name;
    designationController.text = widget.employee.desg;
    isFemale = widget.employee.isMale ? false : true;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          'Update Employee',
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
                enabled: false,
                focusNode: _focusNode,
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'Male',
                        style: TextStyle(
                          fontWeight: isFemale ? FontWeight.normal : FontWeight.bold,
                          color: isFemale ? Colors.grey : Colors.blue
                        ),
                      ),
                      Icon(Icons.male, color: isFemale ? Colors.grey : Colors.blue),
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
                  Row(
                    children: <Widget>[
                      Text(
                        'Female',
                        style: TextStyle(
                          fontWeight: isFemale ? FontWeight.bold : FontWeight.normal,
                          color: isFemale ? Colors.pink : Colors.grey
                        ),
                      ),
                      Icon(Icons.male, color: isFemale ? Colors.pink : Colors.grey),
                    ],
                  ),
                ],
              ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(8.0))
                        ),
                        onPressed: (){},
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: (){
                          setState(() {
                          idController.text = '';
                          nameController.text = '';
                          designationController.text = '';
                          isFemale = false;
                          _focusNode.requestFocus();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))
                        ),
                        child: Text(
                          'Reset',
                           style: TextStyle(color: Colors.white),
                        ),
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