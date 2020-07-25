import 'package:flutter/foundation.dart';

class TodoItem with ChangeNotifier {
  String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  bool filed;
  bool finished;

  TodoItem({
    @required this.title,
    this.id,
    this.description,
    this.filed = false,
    this.finished = false,
    this.createdAt,
    this.updatedAt,
  });

  TodoItem.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'],
        finished = json['finished'],
        filed = json['filed'],
        createdAt = DateTime.parse(json['createdAt']),
        updatedAt = DateTime.parse(json['updatedAt']);

  void toggleFiledState() {
    this.filed = !this.filed;
    notifyListeners();
  }

  void toggleFinishedState() {
    this.finished = !this.finished;
    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'filed': filed,
      'finished': finished,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String()
    };
  }
}
