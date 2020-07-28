import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo/app/controllers/todos_controller.dart';
import 'package:todo/app/models/todo_item.dart';
import 'package:todo/widgets/todo/todo_item_widget.dart';

class TodosListWidget extends StatelessWidget {
  final List<TodoItem> items;
  final Function refreshData;

  TodosListWidget({
    @required this.items,
    @required this.refreshData,
  });

  @override
  Widget build(BuildContext context) {
    final TodosController todosController = Provider.of(context);

    final Widget emptyTodosMessage = Center(
      child: (Text('No ToDos found.')),
    );

    return RefreshIndicator(
      onRefresh: refreshData,
      child: items.length == 0
          ? Stack(
              children: <Widget>[ListView(), emptyTodosMessage],
            )
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Observer(builder: (context) {
                  TodoItem item =
                      this.items.asObservable().toList().elementAt(index);

                  int previousIndex = todosController.todos.indexOf(item);

                  return TodoItemWidget(
                    item: item,
                    updateTodo: (todo) {
                      todosController.updateTodo(todo, previousIndex);
                    },
                  );
                });
              },
            ),
    );
  }
}
