import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:todo/app/models/todo_item.dart';
import 'package:todo/utils/app_urls.dart';

class TodosRepository {
  static final String todosUrl = "${AppUrls.baseUrl}/todos";
  static Dio dio = Dio();

  final String token;
  final String userId;

  TodosRepository({@required this.token, @required this.userId});

  Future<TodoItem> saveTodo(TodoItem todo) async {
    final response = await dio.post<Map<String, dynamic>>(
        "${AppUrls.baseUrl}/$userId/todos.json?auth=$token",
        data: json.encode(todo.toJson()));

    TodoItem savedTodo = todo;
    savedTodo.id = response.data['name'];

    return savedTodo;
  }

  Future<List<TodoItem>> fetchTodos() async {
    final response = await dio.get<Map<String, dynamic>>(
        "${AppUrls.baseUrl}/$userId/todos.json?auth=$token");

    List<TodoItem> items = [];
    if (response.data != null) {
      response.data.forEach((key, value) {
        TodoItem todo = TodoItem.fromJson(value);
        todo.id = key;
        items.add(todo);
      });
    }

    return items;
  }

  Future<void> updateTodo(TodoItem todo) async {
    await dio.put(
        "${AppUrls.baseUrl}/$userId/todos/${todo.id}.json?auth=$token",
        data: json.encode(todo.toJson()));
  }

  Future<void> deleteTodo(TodoItem todo) async {
    await dio
        .delete("${AppUrls.baseUrl}/$userId/todos/${todo.id}.json?auth=$token");
  }
}
