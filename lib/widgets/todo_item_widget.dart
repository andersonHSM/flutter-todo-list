import 'package:flutter/material.dart';
import 'package:todo/app/models/todo_item.dart';

class TodoItemWidget extends StatelessWidget {
  final TodoItem item;

  TodoItemWidget({this.item});
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) {
        return null;
      },
      confirmDismiss: (_) {
        // TODO - implementar lógica de arquivamento
        return Future.value(false);
      },
      key: Key(item.id),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CheckboxListTile(
              title: Text(item.title),
              subtitle: Text(item.description ?? ''),
              value: item.finished,
              onChanged: (_) {
                item.toggleFinishedState();
              }),
        ),
      ),
    );
  }
}
