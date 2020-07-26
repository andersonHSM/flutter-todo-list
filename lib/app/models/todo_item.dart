import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

part 'todo_item.g.dart';

class TodoItem = _TodoItem with _$TodoItem;

abstract class _TodoItem with Store {
  @observable
  String id;
  @observable
  String title;
  @observable
  String description;
  final DateTime createdAt;
  @observable
  DateTime updatedAt;
  @observable
  bool filed;
  @observable
  bool finished;
  @observable
  String tagId;

  _TodoItem({
    @required this.title,
    this.id,
    this.description,
    this.filed = false,
    this.finished = false,
    this.createdAt,
    this.updatedAt,
    this.tagId,
  });

  _TodoItem.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'],
        finished = json['finished'],
        filed = json['filed'],
        createdAt = DateTime.parse(json['createdAt']),
        updatedAt = DateTime.parse(json['updatedAt']);

  @action
  void toggleFiledState() {
    this.filed = !this.filed;
  }

  @action
  void toggleFinishedState() {
    this.finished = !this.finished;
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'filed': filed,
      'finished': finished,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String()
    };
  }
}
