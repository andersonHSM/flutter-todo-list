import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app/controllers/todos_controller.dart';
import 'package:todo/app/models/todo_item.dart';
import 'package:todo/repositories/todos_repository.dart';

class TodoFormWidget extends StatefulWidget {
  @override
  _TodoFormWidgetState createState() => _TodoFormWidgetState();
}

class _TodoFormWidgetState extends State<TodoFormWidget> {
  TodosController todosController;
  bool sendingRequest = false;
  final _form = GlobalKey<FormState>();

  TodoItem todo;

  final Map<String, dynamic> _formData = {};

  @override
  void initState() {
    super.initState();
    todosController = Provider.of<TodosController>(context, listen: false);
  }

  Future<void> _saveTodo() async {
    final formState = _form.currentState;
    final isFormValid = formState.validate();

    if (!isFormValid) return;

    formState.save();

    final saveTime = DateTime.now();

    final todo = TodoItem(
      title: _formData['title'],
      description: _formData['description'],
      createdAt: saveTime,
      updatedAt: saveTime,
    );

    setState(() {
      sendingRequest = true;
    });

    try {
      final response = await TodosRepository.saveTodo(todo);

      todosController.addTodo(response);

      Navigator.of(context).pop();
    } catch (e) {} finally {
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
                  onSaved: (value) => _formData['title'] = value,
                  decoration: InputDecoration(
                    labelText: 'Title',
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
                  onSaved: (value) => _formData['description'] = value,
                  decoration: InputDecoration(
                    labelText: 'Description',
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
