import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:todo/app/models/todo_item.dart';
import 'package:todo/utils/app_urls.dart';

class TodosRepository {
  static final String todosUrl = "${AppUrls.baseUrl}/todos";
  static Dio dio = Dio();

  static Future<TodoItem> saveTodo(TodoItem todo) async {
    final response = await dio.post<Map<String, dynamic>>("$todosUrl.json",
        data: json.encode(todo.toJson()));

    TodoItem savedTodo = todo;
    savedTodo.id = response.data['name'];

    return savedTodo;
  }

  static Future<List<TodoItem>> fetchTodos() async {
    final response = await dio.get<Map<String, dynamic>>("$todosUrl.json");

    List<TodoItem> items = [];
    response.data.forEach((key, value) {
      TodoItem todo = TodoItem.fromJson(value);
      todo.id = key;
      items.add(todo);
    });

    return items;
  }

  static Future<void> updateTodo(TodoItem todo) async {
    await dio.put("$todosUrl/${todo.id}.json",
        data: json.encode(todo.toJson()));
  }

  static Future<void> deleteTodo(TodoItem todo) async {
    await dio.delete("$todosUrl/${todo.id}.json");
  }
}
