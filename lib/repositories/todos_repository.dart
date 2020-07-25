import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:todo/app/models/todo_item.dart';
import 'package:todo/utils/app_urls.dart';

class TodosRepository {
  static final String todosUrl = "${AppUrls.baseUrl}/todos.json";
  static Dio dio = Dio();

  static Future<TodoItem> saveTodo(TodoItem todo) async {
    final response = await dio.post<Map<String, dynamic>>(todosUrl,
        data: json.encode(todo.toJson()));
    // print(response.data);
    TodoItem savedTodo = todo;
    savedTodo.id = response.data['name'];

    return savedTodo;
  }

  static Future<List<TodoItem>> fetchTodos() async {
    final Response<Map<String, dynamic>> response = await dio.get(todosUrl);

    List<TodoItem> items = [];
    response.data.forEach((key, value) {
      TodoItem todo = TodoItem.fromJson(value);
      todo.id = key;
      items.add(todo);
    });

    return items;
  }
}
