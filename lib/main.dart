import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'To-Do-List', home: TodoList());
  }
}

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<String> _todoList = <String>[];
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: ListView(children: _getItems()),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayDialog(context),
        tooltip: 'Add Item',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addTodoItem(String title) {
    //Wrapping it inside a set state will notify
    // the app that the state has changed

    setState(() {
      _todoList.add(title);
    });
    _textFieldController.clear();
  }

  //Generate list of item widgets
  Widget _buildTodoItem(String title) {
    return ListTile(
      title: Text(title),
    );
  }

  //Generate a single item widget
  Future<AlertDialog> _displayDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add a task to your List'),
            content: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: 'Enter task here'),
            ),
            actions: <Widget>[
              //ignore: deprecated_member_case, deprecated_member_use
              FlatButton(
                child: const Text('ADD'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _addTodoItem(_textFieldController.text);
                },
              ),
              // ignore: deprecated_member_use
              FlatButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  List<Widget> _getItems() {
    final List<Widget> _todoWidgets = <Widget>[];
    for (String title in _todoList) {
      _todoWidgets.add(_buildTodoItem(title));
    }
    return _todoWidgets;
  }
}
