import 'package:mobx/mobx.dart';

import 'package:todo/app/models/todo_item.dart';

class TodosControler with Store {
  @observable
  List<TodoItem> todos;
}
