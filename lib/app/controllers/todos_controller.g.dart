// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todos_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TodosController on _TodosController, Store {
  final _$todosAtom = Atom(name: '_TodosController.todos');

  @override
  List<TodoItem> get todos {
    _$todosAtom.reportRead();
    return super.todos;
  }

  @override
  set todos(List<TodoItem> value) {
    _$todosAtom.reportWrite(value, super.todos, () {
      super.todos = value;
    });
  }

  final _$_TodosControllerActionController =
      ActionController(name: '_TodosController');

  @override
  void setTodos(List<TodoItem> items) {
    final _$actionInfo = _$_TodosControllerActionController.startAction(
        name: '_TodosController.setTodos');
    try {
      return super.setTodos(items);
    } finally {
      _$_TodosControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
todos: ${todos}
    ''';
  }
}
