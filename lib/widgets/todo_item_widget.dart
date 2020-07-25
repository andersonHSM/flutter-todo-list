import 'package:flutter/material.dart';
import 'package:todo/app/models/todo_item.dart';

class TodoItemWidget extends StatelessWidget {
  final TodoItem item;
  final Function confirmDismiss;

  TodoItemWidget({this.item, this.confirmDismiss});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
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
              title: Text(item.title),
              subtitle: Text(item.description),
              value: item.finished,
              onChanged: (_) {
                item.toggleFinishedState();
              }),
        ),
      ),
    );
  }
}
