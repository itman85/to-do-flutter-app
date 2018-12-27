import 'package:flutter/material.dart';

class ToDoScreen extends StatefulWidget{
  @override
  ToDoScreenState createState() {
    // TODO: implement createState
    return new ToDoScreenState();
  }

}

class ToDoScreenState extends State<ToDoScreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Colors.black87,
      body: Column(),
      floatingActionButton:  new FloatingActionButton(
        tooltip: "Add Item",
          backgroundColor: Colors.redAccent,
          child: new ListTile(
            title: new Icon(Icons.add),
          ),
          onPressed: showFormDialog),
    );
  }

  void showFormDialog(){

  }

}