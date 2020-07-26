import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app/controllers/tags_controller.dart';
import 'package:todo/app/controllers/todos_controller.dart';
import 'package:todo/app/models/todo_item.dart';
import 'package:todo/repositories/tags_repository.dart';
import 'package:todo/repositories/todos_repository.dart';
import 'package:todo/widgets/shared/form_actions.dart';
import 'package:todo/widgets/tag/tag_choose_list.dart';

class TodoFormWidget extends StatefulWidget {
  final TodoItem todo;

  TodoFormWidget({this.todo});

  @override
  _TodoFormWidgetState createState() => _TodoFormWidgetState();
}

class _TodoFormWidgetState extends State<TodoFormWidget> {
  TodosController todosController;
  TagsController tagsController;

  bool sendingRequest = false;
  int _tagIndex = 0;

  final _form = GlobalKey<FormState>();
  final _descriptionFocusNode = FocusNode();

  final Map<String, dynamic> _formData = {};

  @override
  void initState() {
    super.initState();
    todosController = Provider.of<TodosController>(context, listen: false);
    tagsController = Provider.of<TagsController>(context, listen: false);

    _initForm();
  }

  Future<void> _initForm() async {
    _formData['title'] = widget.todo?.title;
    _formData['description'] = widget.todo?.description;
    _formData['tagId'] = widget.todo?.tagId;

    if (widget.todo?.tagId != null) {
      _tagIndex = tagsController.tags.toList().indexWhere((tag) {
        return tag.id == widget.todo.tagId;
      });
    }

    if (_tagIndex == -1) {
      _tagIndex = 0;
    }
  }

  _handleTagSelect(String id) {
    _formData['tagId'] = id;
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
            tagId: _formData['tagId']);
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
          tagId: widgetTodo.tagId,
        );

        todo.updatedAt = saveTime;
        todo.title = _formData['title'];
        todo.description = _formData['description'];
        todo.tagId = _formData['tagId'];

        await TodosRepository.updateTodo(todo);

        int previousTodoIndex = todosController.todos.indexOf(widgetTodo);

        todosController.updateTodo(todo, previousTodoIndex);
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
                Container(
                  child: TagChooseList(
                    tags: tagsController.tags.toList(),
                    initialIndex: _tagIndex,
                    handleSelect: (id) => _handleTagSelect(id),
                  ),
                ),
                FormActions(
                  saveFunction: _saveTodo,
                  sendingRequest: sendingRequest,
                )
              ],
            ),
          )),
    );
  }
}
