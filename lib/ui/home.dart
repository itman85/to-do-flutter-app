import 'package:flutter/material.dart';
import 'package:to_do_app/ui/todo_screen.dart';

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: Text("To-Do App"),
        backgroundColor: Colors.black54,
      ),
      body: new ToDoScreen()
    );
  }

}