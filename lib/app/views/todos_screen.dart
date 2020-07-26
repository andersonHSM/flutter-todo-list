import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo/app/controllers/todos_controller.dart';
import 'package:todo/app/models/todo_item.dart';
import 'package:todo/repositories/todos_repository.dart';
import 'package:todo/widgets/tag_form_widget.dart';
import 'package:todo/widgets/todo_form_widget.dart';
import 'package:todo/widgets/todo_list_widget.dart';

enum FormsModals { TODO, TAG }

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
  ];

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
      default:
        return todosController.todos;
    }
  }

  Future<void> _openFormDialog(FormsModals modal) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        switch (modal) {
          case FormsModals.TAG:
            return TagFormWidget();
          // case FormsModals.TODO:
          //   return TodoFormWidget();
          default:
            return TodoFormWidget();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          key: GlobalKey(),
          appBar: AppBar(
            title: Text('ToDo List'),
            bottom: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 6,
              tabs: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Today's"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("All"),
                ),
              ],
            ),
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
          body: Observer(
            builder: (context) {
              List<TodoItem> todos = _selectTodosToShow(_popupValue).toList();
              List<TodoItem> todaysTodos = todos
                  .where(
                      (element) => element.createdAt.day == DateTime.now().day)
                  .toList();

              return Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: TabBarView(
                  children: <Widget>[
                    TodosListWidget(
                      items: todaysTodos,
                      fetchTodos: _fetchTodos,
                    ),
                    TodosListWidget(
                      items: todos,
                      fetchTodos: _fetchTodos,
                    )
                  ],
                ),
              );
            },
          ),
          floatingActionButton: SpeedDial(
            child: Icon(Icons.add),
            children: [
              SpeedDialChild(
                label: 'ToDo',
                child: Icon(Icons.assignment),
                onTap: () => _openFormDialog(FormsModals.TODO),
              ),
              SpeedDialChild(
                  label: 'Tag',
                  child: Icon(Icons.local_offer),
                  onTap: () => _openFormDialog(FormsModals.TAG))
            ],
          ) /* FloatingActionButton(
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
        ), */
          ),
    );
  }
}
