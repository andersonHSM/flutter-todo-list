import 'package:mobx/mobx.dart';

import 'package:todo/app/models/todo_item.dart';

part 'todos_controller.g.dart';

class TodosController = _TodosController with _$TodosController;

abstract class _TodosController with Store {
  @observable
  List<TodoItem> todos = [];

  @action
  void setTodos(List<TodoItem> items) {
    todos = items;
  }
}
