import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app/controllers/todos_controller.dart';
import 'package:todo/app/models/todo_item.dart';
import 'package:todo/widgets/todo/todo_item_widget.dart';

class TodosListWidget extends StatelessWidget {
  final List<TodoItem> items;
  final Function fetchTodos;

  TodosListWidget({
    @required this.items,
    @required this.fetchTodos,
  });

  @override
  Widget build(BuildContext context) {
    final TodosController todosController = Provider.of(context);

    final Widget emptyTodosMessage = Center(
      child: (Text('No ToDos found.')),
    );

    return RefreshIndicator(
      onRefresh: fetchTodos,
      child: items.length == 0
          ? Stack(
              children: <Widget>[ListView(), emptyTodosMessage],
            )
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                TodoItem item = items.elementAt(index);
                return Provider.value(
                  value: item,
                  child: Consumer<TodoItem>(
                    builder: (_, value, child) {
                      return TodoItemWidget(
                        item: value,
                        updateTodo: (todo) {
                          todosController.updateTodo(todo, index);
                        },
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
