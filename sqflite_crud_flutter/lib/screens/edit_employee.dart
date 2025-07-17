import 'package:flutter/material.dart';
import 'package:sqflite_crud_flutter/database/my_database.dart';
import 'package:sqflite_crud_flutter/models/employee.dart';
import 'package:sqflite_crud_flutter/screens/home.dart';

class EditEmployee extends StatefulWidget {
  final MyDatabase mydatabase;
  final Employee employee;
  const EditEmployee({super.key, required this.employee, required this.mydatabase});

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
  void initState() {
    // TODO: implement initState
    super.initState();
    //Pass the data on CONTROLLERS from Navigation.
    idController.text = '${widget.employee.empId}';
    nameController.text = widget.employee.empName;
    designationController.text = widget.employee.empDesignation;
    isFemale = widget.employee.isMale ? false : true;
  }
  @override
  Widget build(BuildContext context) {



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
                        onPressed: () async {
                           Employee employee = Employee(
                            empId: int.parse(idController.text),
                            empName: nameController.text,
                            empDesignation: designationController.text,
                            isMale: !isFemale);

                            await widget.mydatabase.updateEmp(employee);

                            if(!mounted) return;

                              //Show snackbar if added.
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.orange,
                                content: Text('${employee.empName} is updated!')));

                              //Navigate to previous route.
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Home(),
                                ),
                                (route) => false);

                        },
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