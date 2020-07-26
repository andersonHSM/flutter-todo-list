import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:todo/app/models/todo_item.dart';
import 'package:todo/repositories/todos_repository.dart';

class TodoItemWidget extends StatelessWidget {
  final TodoItem item;
  final Function(TodoItem) confirmDismiss;
  final Function(TodoItem) updateTodo;

  TodoItemWidget(
      {@required this.item,
      @required this.confirmDismiss,
      @required this.updateTodo});

  @override
  Widget build(BuildContext context) {
    return Observer(
      key: Key(item.id),
      name: item.title,
      builder: (_) => Dismissible(
        onDismissed: (direction) {
          confirmDismiss(item);
        },
        confirmDismiss: (direction) async {
          switch (direction) {
            case DismissDirection.endToStart:
              bool updatedValue = await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                        "Do you wish to ${!item.filed ? 'file' : 'unfile'} this ToDo?"),
                    actions: <Widget>[
                      RaisedButton(
                        child: Text('Confirm'),
                        onPressed: () {
                          bool file = true;
                          if (item.filed) {
                            file = false;
                          }
                          item.updateFiledState(file);
                          Navigator.of(context).pop(true);
                        },
                      )
                    ],
                  );
                },
              );

              if (updatedValue == null) {
                return updatedValue = false;
              }

              return updatedValue;

            default:
              return Future.value(false);
          }
        },
        key: Key(item.id),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CheckboxListTile(
                title: Text(
                  item.title,
                  style: TextStyle(
                      decoration: item.finished
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
                subtitle: Text(item.description),
                value: item.finished,
                onChanged: (_) async {
                  try {
                    item.updatedAt = DateTime.now();

                    item.toggleFinishedState();
                    updateTodo(item);

                    await TodosRepository.updateTodo(item);
                  } catch (e) {
                    print(e);
                    item.toggleFinishedState();
                  }
                }),
          ),
        ),
      ),
    );
  }
}
