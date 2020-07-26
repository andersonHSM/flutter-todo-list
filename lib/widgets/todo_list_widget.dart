import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app/controllers/todos_controller.dart';
import 'package:todo/app/models/todo_item.dart';
import 'package:todo/widgets/todo_item_widget.dart';

class TodosListWidget extends StatelessWidget {
  final List<TodoItem> items;
  final Function confirmDismiss;

  TodosListWidget({@required this.items, @required this.confirmDismiss});

  @override
  Widget build(BuildContext context) {
    final TodosController todosController = Provider.of(context);
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        TodoItem item = items.elementAt(index);
        return Provider.value(
          value: item,
          child: Consumer<TodoItem>(
            builder: (_, value, child) {
              return TodoItemWidget(
                item: value,
                confirmDismiss: (item) => items.remove(item),
                updateTodo: (todo) => todosController.updateTodo(todo),
              );
            },
          ),
        );
      },
    );
  }
}
