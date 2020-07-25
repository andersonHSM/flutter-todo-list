import 'package:flutter/material.dart';
import 'package:todo/app/models/todo_item.dart';
import 'package:todo/widgets/todo_list_widget.dart';
import 'package:uuid/uuid.dart';

class PopupItem {
  final IconData icon;
  final String text;
  final String value;

  PopupItem({this.icon, this.text, this.value});
}

class TodosScreen extends StatefulWidget {
  @override
  _TodosScreenState createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  static Uuid uuid = Uuid();
  final List<PopupItem> _popupItems = [
    PopupItem(
      icon: Icons.list,
      text: 'Listar todos',
      value: 'all',
    ),
    PopupItem(
      icon: Icons.archive,
      text: 'Arquivados',
      value: 'filed',
    ),
  ];

  // TODO - não manter hardcoded
  final List<TodoItem> _todosItems = [
    TodoItem(
      id: uuid.v4(),
      title: 'Construir base aplicação',
    ),
    TodoItem(
        id: uuid.v4(),
        title: 'Permitir card atualizável',
        description: 'Permitir que ao clicar como finalzado, o card atualize')
  ];

  // TODO - refatorar para outro widget
  List<PopupMenuItem<String>> _buildPopupMenuItems(
      BuildContext context, List<PopupItem> list) {
    return list.map((item) {
      return PopupMenuItem<String>(
        value: item.value,
        child: Row(
          children: <Widget>[
            Icon(item.icon, color: Theme.of(context).primaryColor),
            SizedBox(width: 5),
            Text(
              item.text,
            ),
          ],
        ),
      );
    }).toList();
  }

  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo List'),
        actions: <Widget>[
          PopupMenuButton<String>(
            itemBuilder: (context) {
              return _buildPopupMenuItems(context, _popupItems);
            },
            icon: Icon(Icons.filter_list),
            onSelected: (value) {
              print(value);
            },
          ),
        ],
      ),
      body: TodosListWidget(
        items: _todosItems,
      ),
    );
  }
}
