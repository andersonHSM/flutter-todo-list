import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo/app/controllers/tags_controller.dart';
import 'package:todo/app/controllers/todos_controller.dart';
import 'package:todo/app/models/tag.dart';

import 'package:todo/app/models/todo_item.dart';
import 'package:todo/repositories/todos_repository.dart';
import 'package:todo/widgets/todo/todo_form_widget.dart';
import 'package:todo/widgets/todo/todo_item_actions.dart';

class TodoItemWidget extends StatelessWidget {
  final TodoItem item;
  final Function(TodoItem) updateTodo;

  TodoItemWidget({
    @required this.item,
    @required this.updateTodo,
  });

  Future<bool> _confirmDismiss(
      BuildContext context, DismissDirection direction) async {
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
  }

  Future<void> _dismissItem(TodoItem todo) async {
    try {
      todo.toggleFiledState();

      await TodosRepository.updateTodo(todo);
    } catch (e) {
      todo.toggleFiledState();
    }
  }

  Future<void> _markAsFinished(TodoItem todo) async {
    try {
      todo.updatedAt = DateTime.now();

      todo.toggleFinishedState();

      updateTodo(todo);

      await TodosRepository.updateTodo(todo);
    } catch (e) {
      todo.toggleFinishedState();
    }
  }

  void _showEditModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return TodoFormWidget(
          todo: this.item,
        );
      },
    );
  }

  Tag _selectTodoTag(TagsController tagsController, TodoItem todo) {
    List<Tag> tags = tagsController.tags
        .toList()
        .where((tag) => tag.id == todo.tagId)
        .toList();

    if (tags.length > 0) {
      return tags.elementAt(0);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final TodosController todosController = Provider.of(context, listen: false);
    final TagsController tagsController = Provider.of(context, listen: false);

    Tag todoTag = _selectTodoTag(tagsController, this.item);

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
          await _dismissItem(item);
        },
        confirmDismiss: (direction) async {
          return await _confirmDismiss(context, direction);
        },
        key: Key(this.item.id),
        child: Container(
          margin: const EdgeInsets.all(8.0),
          child: Card(
            child: Column(
              children: <Widget>[
                CheckboxListTile(
                  title: Text(
                    this.item.title,
                    style: TextStyle(
                        decoration: this.item.finished
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ),
                  subtitle: Text(this.item.description),
                  value: item.finished,
                  onChanged: (_) async {
                    await _markAsFinished(this.item);
                  },
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TodoItemActions(
                    tag: todoTag,
                    todoItem: this.item,
                    todosController: todosController,
                    showEditDialog: () => _showEditModal(context),
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
