import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo/app/controllers/todos_controller.dart';

import 'package:todo/app/models/todo_item.dart';
import 'package:todo/repositories/todos_repository.dart';
import 'package:todo/widgets/todo/todo_form_widget.dart';

class TodoItemWidget extends StatelessWidget {
  final TodoItem item;
  final Function(TodoItem) updateTodo;

  TodoItemWidget({
    @required this.item,
    @required this.updateTodo,
  });

  @override
  Widget build(BuildContext context) {
    final todosController =
        Provider.of<TodosController>(context, listen: false);

    return Observer(
      builder: (_) => Dismissible(
        background: Container(
          color: Theme.of(context).accentColor,
          margin: EdgeInsets.only(top: 8, right: 12, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Icon(item.filed ? Icons.unarchive : Icons.archive,
                  size: 40, color: Colors.white),
              SizedBox(
                width: 50,
              )
            ],
          ),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (_) async {
          try {
            item.toggleFiledState();

            await TodosRepository.updateTodo(item);
          } catch (e) {
            item.toggleFiledState();
          }
        },
        confirmDismiss: (direction) async {
          switch (direction) {
            case DismissDirection.endToStart:
              bool updatedValue = await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("${!item.filed ? 'File' : 'Unfile'} ToDo?"),
                    actions: <Widget>[
                      RaisedButton(
                        color: Theme.of(context).accentColor,
                        child: Text('Confirm'),
                        onPressed: () async {
                          Navigator.of(context).pop(true);
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
                      print(item);
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
                      Tooltip(
                        message: 'Remove ToDo',
                        child: IconButton(
                          icon: Icon(Icons.delete,
                              color: Theme.of(context).errorColor),
                          onPressed: () async {
                            int todoIndex = todosController.todos.indexOf(item);

                            final confirmation = await showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text('Delete ToDo?'),
                                      actions: <Widget>[
                                        RaisedButton(
                                          color: Theme.of(context).accentColor,
                                          child: Text('Confirm'),
                                          onPressed: () =>
                                              Navigator.of(context).pop(true),
                                        )
                                      ],
                                    ));
                            if (confirmation != null && confirmation == true) {
                              try {
                                todosController.removeTodo(item);
                                await TodosRepository.deleteTodo(item);
                              } catch (e) {
                                todosController.addTodo(item, todoIndex);
                              }
                            }
                          },
                        ),
                      ),
                      Tooltip(
                        message: 'Edit ToDo',
                        child: IconButton(
                          color: Theme.of(context).accentColor,
                          icon: Icon(
                            Icons.edit,
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
                        ),
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
