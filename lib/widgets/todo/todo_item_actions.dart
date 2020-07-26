import 'package:flutter/material.dart';
import 'package:todo/app/controllers/todos_controller.dart';
import 'package:todo/app/models/todo_item.dart';
import 'package:todo/repositories/todos_repository.dart';

class TodoItemActions extends StatelessWidget {
  final TodosController todosController;
  final TodoItem todoItem;
  final Function showEditDialog;

  TodoItemActions({
    @required this.todosController,
    @required this.todoItem,
    @required this.showEditDialog,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Tooltip(
          message: 'Remove ToDo',
          child: IconButton(
            icon: Icon(Icons.delete, color: Theme.of(context).errorColor),
            onPressed: () async {
              int todoIndex = todosController.todos.indexOf(todoItem);

              final confirmation = await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text('Delete ToDo?'),
                        actions: <Widget>[
                          RaisedButton(
                            color: Theme.of(context).accentColor,
                            child: Text('Confirm'),
                            onPressed: () => Navigator.of(context).pop(true),
                          )
                        ],
                      ));
              if (confirmation != null && confirmation == true) {
                try {
                  todosController.removeTodo(todoItem);
                  await TodosRepository.deleteTodo(todoItem);
                } catch (e) {
                  todosController.addTodo(todoItem, todoIndex);
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
            onPressed: showEditDialog,
          ),
        )
      ],
    );
  }
}
