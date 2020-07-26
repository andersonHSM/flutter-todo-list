import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo/app/controllers/tags_controller.dart';
import 'package:todo/app/controllers/todos_controller.dart';
import 'package:todo/app/models/todo_item.dart';
import 'package:todo/repositories/tags_repository.dart';
import 'package:todo/repositories/todos_repository.dart';
import 'package:todo/widgets/tag/tag_form_widget.dart';
import 'package:todo/widgets/todo/todo_form_widget.dart';
import 'package:todo/widgets/todo/todo_list_widget.dart';

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
  TagsController tagsController;

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
    this.tagsController = Provider.of<TagsController>(context, listen: false);

    _loadData();
  }

  Future<void> _fetchTodos() async {
    final todos = await TodosRepository.fetchTodos();

    todosController.setTodos(todos);
  }

  Future<void> _fetchTags() async {
    final tags = await TagsRepository().fetchTags();

    tagsController.setTags(tags);
  }

  Future<void> _loadData() async {
    await Future.wait([_fetchTags(), _fetchTodos()]);
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
                .where((element) => element.createdAt.day == DateTime.now().day)
                .toList();

            return Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: TabBarView(
                children: <Widget>[
                  TodosListWidget(
                    items: todaysTodos,
                    refreshData: _loadData,
                  ),
                  TodosListWidget(
                    items: todos,
                    refreshData: _loadData,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
