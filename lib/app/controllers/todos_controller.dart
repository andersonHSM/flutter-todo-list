import 'package:mobx/mobx.dart';

import 'package:todo/app/models/todo_item.dart';

part 'todos_controller.g.dart';

class TodosController = _TodosController with _$TodosController;

abstract class _TodosController with Store {
  @observable
  ObservableList<TodoItem> todos = ObservableList.of([]);

  @computed
  ObservableList<TodoItem> get unfiledTodos =>
      todos.where((todo) => !todo.filed).toList().asObservable();

  @computed
  ObservableList<TodoItem> get filedTodos =>
      todos.where((todo) => todo.filed).toList().asObservable();

  @computed
  ObservableList<TodoItem> get finishedTodos =>
      todos.where((todo) => todo.finished).toList().asObservable();

  @computed
  ObservableList<TodoItem> get unfinishedTodos =>
      todos.where((todo) => !todo.finished).toList().asObservable();

  @action
  void setTodos(List<TodoItem> items) {
    todos.clear();
    todos.addAll(items);
  }

  @action
  void addTodo(TodoItem todo) {
    todos.add(todo);
  }

  @action
  void updateTodo(TodoItem todo) {
    int index = todos.indexOf(todo);

    todos[index] = todo;
  }
}
