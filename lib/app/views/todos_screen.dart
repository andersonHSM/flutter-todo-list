import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo/app/controllers/todos_controller.dart';
import 'package:todo/app/models/todo_item.dart';
import 'package:todo/repositories/todos_repository.dart';
import 'package:todo/widgets/todo_form_widget.dart';
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
  TodosController todosController;

  String _popupValue = 'all';

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
    PopupItem(
      icon: Icons.save,
      text: 'Finalizados',
      value: 'finished',
    ),
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

  @override
  void initState() {
    super.initState();
    this.todosController = Provider.of<TodosController>(context, listen: false);

    _fetchTodos();
  }

  Future<void> _fetchTodos() async {
    final todos = await TodosRepository.fetchTodos();

    todosController.setTodos(todos);
  }

  ObservableList<TodoItem> _selectTodosToShow(String value) {
    switch (value) {
      case 'all':
        return todosController.unfiledTodos;
      case 'filed':
        return todosController.filedTodos;
      case 'finished':
        return todosController.finishedTodos;
      default:
        return todosController.todos;
    }
  }

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
              setState(() {
                _popupValue = value;
              });
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _fetchTodos,
        child: Observer(
          builder: (context) {
            ObservableList<TodoItem> todos = _selectTodosToShow(_popupValue);

            if (todos.length == 0) {
              return Center(
                child: (Text('No ToDos found.')),
              );
            }
            return Padding(
              padding: const EdgeInsets.only(bottom: 75),
              child: TodosListWidget(
                items: todos,
                confirmDismiss: () => setState(() {}),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return TodoFormWidget();
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
