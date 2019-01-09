import 'package:flutter/material.dart';
import 'package:to_do_app/model/todo_item.dart';
import 'package:to_do_app/util/database_helper.dart';

/**
 * Phan Nguyen
 */
class ToDoScreen extends StatefulWidget {
  @override
  ToDoScreenState createState() {
    // TODO: implement createState
    return new ToDoScreenState();
  }
}

class ToDoScreenState extends State<ToDoScreen> {
  final TextEditingController _textEditingController =
      new TextEditingController();
  var db = new DatabaseHelper();
  final List<ToDoItem> _itemList = <ToDoItem>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _readToDoList();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        children: <Widget>[
          new Flexible(
            child: new ListView.builder(
                padding: new EdgeInsets.all(8.0),
                reverse: false,
                itemCount: _itemList.length,
                itemBuilder: (_, int index) {
                  return new Card(
                    color: Colors.white10,
                    child: new ListTile(
                      title: _itemList[index],
                      onLongPress: () => debugPrint(""),
                      trailing: new Listener(
                        key: new Key(_itemList[index].itemName),
                        child: new Icon(
                          Icons.remove_circle,
                          color: Colors.redAccent,
                        ),
                        onPointerDown: (pointerEvent) => _deleteToDoItem(_itemList[index].id,index),
                      ),
                    ),
                  );
                }),
          ),
          new Divider(
            height: 1.0,
          )
        ],
      ),
      floatingActionButton: new FloatingActionButton(
          tooltip: "Add Item",
          backgroundColor: Colors.redAccent,
          child: new ListTile(
            title: new Icon(Icons.add),
          ),
          onPressed: showFormDialog),
    );
  }

  void showFormDialog() {
    var alert = new AlertDialog(
      content: new Row(
        children: <Widget>[
          new Expanded(
              child: new TextField(
            controller: _textEditingController,
            autofocus: true,
            decoration: new InputDecoration(
                labelText: "Item",
                hintText: "Input to-do task",
                icon: new Icon(Icons.note_add)),
          ))
        ],
      ),
      actions: <Widget>[
        new FlatButton(
            onPressed: () {
              _handleSubmit(_textEditingController.text);
              _textEditingController.clear();
              Navigator.pop(context);
            },
            child: Text("Save")),
        new FlatButton(
            onPressed: () => Navigator.pop(context), child: Text("Cancel"))
      ],
    );
    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }

  _readToDoList() async {
    List items = await db.getItems();
    items.forEach((item) {
      //ToDoItem toDoItem = ToDoItem.map(item);
      setState(() {
        _itemList.add(ToDoItem.map(item));
      });
      //print("Db items: ${toDoItem.itemName}");
    });
  }

  void _handleSubmit(String text) async {
    _textEditingController.clear();
    ToDoItem toDoItem = new ToDoItem(text, DateTime.now().toIso8601String());
    int savedItemId = await db.saveItem(toDoItem);
    ToDoItem addedItem = await db.getItem(savedItemId);
    print("Item saved id $savedItemId");
    setState(() {
      _itemList.insert(0, addedItem);
    });
  }

  void _deleteToDoItem(int id,int index) async{
    debugPrint("Deleted Item!");
    await db.deleteItem(id);
    setState(() {
      _itemList.removeAt(index);
    });
  }
}
