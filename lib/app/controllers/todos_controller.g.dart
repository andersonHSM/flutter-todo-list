// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todos_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TodosController on _TodosController, Store {
  Computed<ObservableList<TodoItem>> _$unfiledTodosComputed;

  @override
  ObservableList<TodoItem> get unfiledTodos => (_$unfiledTodosComputed ??=
          Computed<ObservableList<TodoItem>>(() => super.unfiledTodos,
              name: '_TodosController.unfiledTodos'))
      .value;
  Computed<ObservableList<TodoItem>> _$filedTodosComputed;

  @override
  ObservableList<TodoItem> get filedTodos => (_$filedTodosComputed ??=
          Computed<ObservableList<TodoItem>>(() => super.filedTodos,
              name: '_TodosController.filedTodos'))
      .value;
  Computed<ObservableList<TodoItem>> _$finishedTodosComputed;

  @override
  ObservableList<TodoItem> get finishedTodos => (_$finishedTodosComputed ??=
          Computed<ObservableList<TodoItem>>(() => super.finishedTodos,
              name: '_TodosController.finishedTodos'))
      .value;
  Computed<ObservableList<TodoItem>> _$unfinishedTodosComputed;

  @override
  ObservableList<TodoItem> get unfinishedTodos => (_$unfinishedTodosComputed ??=
          Computed<ObservableList<TodoItem>>(() => super.unfinishedTodos,
              name: '_TodosController.unfinishedTodos'))
      .value;

  final _$todosAtom = Atom(name: '_TodosController.todos');

  @override
  ObservableList<TodoItem> get todos {
    _$todosAtom.reportRead();
    return super.todos;
  }

  @override
  set todos(ObservableList<TodoItem> value) {
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
  void clearTodos() {
    final _$actionInfo = _$_TodosControllerActionController.startAction(
        name: '_TodosController.clearTodos');
    try {
      return super.clearTodos();
    } finally {
      _$_TodosControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addTodo(TodoItem todo, [int index]) {
    final _$actionInfo = _$_TodosControllerActionController.startAction(
        name: '_TodosController.addTodo');
    try {
      return super.addTodo(todo, index);
    } finally {
      _$_TodosControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateTodo(TodoItem todo, int index) {
    final _$actionInfo = _$_TodosControllerActionController.startAction(
        name: '_TodosController.updateTodo');
    try {
      return super.updateTodo(todo, index);
    } finally {
      _$_TodosControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeTodo(TodoItem todo) {
    final _$actionInfo = _$_TodosControllerActionController.startAction(
        name: '_TodosController.removeTodo');
    try {
      return super.removeTodo(todo);
    } finally {
      _$_TodosControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
todos: ${todos},
unfiledTodos: ${unfiledTodos},
filedTodos: ${filedTodos},
finishedTodos: ${finishedTodos},
unfinishedTodos: ${unfinishedTodos}
    ''';
  }
}
