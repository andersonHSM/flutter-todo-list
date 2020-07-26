import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app/controllers/todos_controller.dart';
import 'package:todo/app/models/todo_item.dart';
import 'package:todo/repositories/todos_repository.dart';

class TodoFormWidget extends StatefulWidget {
  final TodoItem todo;
  final int index;

  TodoFormWidget({this.todo, this.index});

  @override
  _TodoFormWidgetState createState() => _TodoFormWidgetState();
}

class _TodoFormWidgetState extends State<TodoFormWidget> {
  TodosController todosController;
  bool sendingRequest = false;
  final _form = GlobalKey<FormState>();
  final _descriptionFocusNode = FocusNode();

  final Map<String, dynamic> _formData = {};

  @override
  void initState() {
    super.initState();
    todosController = Provider.of<TodosController>(context, listen: false);
    _formData['title'] = widget.todo?.title;
    _formData['description'] = widget.todo?.description;
  }

  Future<void> _saveTodo() async {
    final formState = _form.currentState;
    final isFormValid = formState.validate();

    if (!isFormValid) return;

    formState.save();

    final saveTime = DateTime.now();

    setState(() {
      sendingRequest = true;
    });

    try {
      TodoItem todo;
      TodoItem todoResponse;

      if (widget.todo == null) {
        todo = TodoItem(
          title: _formData['title'],
          description: _formData['description'],
          createdAt: saveTime,
          updatedAt: saveTime,
        );
        todoResponse = await TodosRepository.saveTodo(todo);
        todosController.addTodo(todoResponse);
      } else {
        final widgetTodo = widget.todo;
        todo = TodoItem(
          createdAt: widgetTodo.createdAt,
          description: widgetTodo.description,
          filed: widgetTodo.filed,
          finished: widgetTodo.finished,
          id: widgetTodo.id,
          title: widgetTodo.title,
          updatedAt: widgetTodo.updatedAt,
        );

        todo.updatedAt = saveTime;
        todo.title = _formData['title'];
        todo.description = _formData['description'];

        await TodosRepository.updateTodo(todo);
        todosController.updateTodo(todo, widget.index);
      }

      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        sendingRequest = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Form(
          key: _form,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  onEditingComplete: () => _descriptionFocusNode.requestFocus(),
                  initialValue: widget.todo?.title ?? '',
                  onSaved: (value) => _formData['title'] = value,
                  decoration: InputDecoration(
                    labelText: 'ToDo Title',
                    alignLabelWithHint: true,
                  ),
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return 'Required field';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  focusNode: _descriptionFocusNode,
                  onFieldSubmitted: (value) {
                    _saveTodo();
                  },
                  initialValue: widget.todo?.description ?? '',
                  onSaved: (value) => _formData['description'] = value,
                  decoration: InputDecoration(
                    labelText: 'ToDo Description',
                    alignLabelWithHint: true,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    RaisedButton(
                      color: Theme.of(context).errorColor,
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    RaisedButton(
                      color: Theme.of(context).accentColor,
                      onPressed: _saveTodo,
                      child: sendingRequest
                          ? Container(
                              width: 25,
                              height: 25,
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.white,
                                strokeWidth: 3,
                              ),
                            )
                          : Text(
                              'Save',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
