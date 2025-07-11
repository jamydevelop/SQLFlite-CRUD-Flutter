import 'package:flutter/material.dart';
import 'package:sqflite_crud_flutter/screens/add_employee.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
      body: Center(
        child: Text('SQFLite CRUD'),
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