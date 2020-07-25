import 'package:mobx/mobx.dart';

import 'package:todo/app/models/todo_item.dart';

part 'todos_controller.g.dart';

class TodosController = _TodosController with _$TodosController;

abstract class _TodosController with Store {
  @observable
  ObservableList<TodoItem> todos = ObservableList.of([]);

  @action
  void setTodos(List<TodoItem> items) {
    todos.addAll(items);
  }

  @action
  void addTodo(TodoItem todo) {
    todos.add(todo);
  }
}
