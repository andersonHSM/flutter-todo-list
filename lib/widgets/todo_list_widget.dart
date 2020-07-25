import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app/models/todo_item.dart';
import 'package:todo/widgets/todo_item_widget.dart';

class TodosListWidget extends StatelessWidget {
  final List<TodoItem> items;

  TodosListWidget({@required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        TodoItem item = items.elementAt(index);
        return ChangeNotifierProvider.value(
            value: item,
            child: Consumer<TodoItem>(
              builder: (context, value, child) {
                print(value);
                return TodoItemWidget(item: value);
              },
            ));
      },
    );
  }
}
