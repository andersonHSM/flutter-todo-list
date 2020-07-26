import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:todo/app/models/todo_item.dart';
import 'package:todo/repositories/todos_repository.dart';
import 'package:todo/widgets/todo_form_widget.dart';

class TodoItemWidget extends StatelessWidget {
  final TodoItem item;
  final Function(TodoItem) updateTodo;

  TodoItemWidget({@required this.item, @required this.updateTodo});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Dismissible(
        direction: DismissDirection.endToStart,
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
                        onPressed: () async {
                          try {
                            item.toggleFiledState();

                            Navigator.of(context).pop(true);

                            await TodosRepository.updateTodo(item);
                          } catch (e) {
                            item.toggleFiledState();
                          }
                        },
                      )
                    ],
                  );
                },
              );

              if (updatedValue == null) {
                return false;
              }

              return updatedValue;

            default:
              return Future.value(false);
          }
        },
        key: Key(item.id),
        child: Container(
          margin: const EdgeInsets.all(8.0),
          child: Card(
            child: Column(
              children: <Widget>[
                CheckboxListTile(
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
                      item.toggleFinishedState();
                    }
                  },
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      RaisedButton(
                        color: Theme.of(context).accentColor,
                        child: Text(
                          'Editar',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return TodoFormWidget(
                                todo: item,
                              );
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 5,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
