import 'package:flutter/material.dart';
import 'package:to_do_app/model/todo_item.dart';
import 'package:to_do_app/util/database_helper.dart';

/**
 * Phan Nguyen
 */
class ToDoScreen extends StatefulWidget{
  @override
  ToDoScreenState createState() {
    // TODO: implement createState
    return new ToDoScreenState();
  }

}

class ToDoScreenState extends State<ToDoScreen>{
  final TextEditingController _textEditingController = new TextEditingController();
  var db = new DatabaseHelper();
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
    var alert = new AlertDialog(
      content: new Row(
        children: <Widget>[
          new Expanded(child: new TextField(
            controller: _textEditingController,
            autofocus: true,
              decoration: new InputDecoration(
                labelText: "Item",
                hintText: "Input to-do task",
                icon: new Icon(Icons.note_add)
              ),
          ))
        ],
      ),
      actions: <Widget>[
          new FlatButton(onPressed: (){
            _handleSubmit(_textEditingController.text);
            _textEditingController.clear();
          }, child: Text("Save")),
        new FlatButton(onPressed: ()=> Navigator.pop(context), child: Text("Cancel"))
      ],
    );
    showDialog(context: context,
            builder:(_){
                return alert;
            });
  }

  _readToDoList() async{
    List items = await db.getItems();
    items.forEach((item){
      ToDoItem toDoItem = ToDoItem.map(item);
    });
  }

  void _handleSubmit(String text) async{
    _textEditingController.clear();
    ToDoItem toDoItem = new ToDoItem(text, DateTime.now().toIso8601String());
    int savedItemId = await db.saveItem(toDoItem);
    print("Item saved id $savedItemId");
  }



}