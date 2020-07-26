import 'package:mobx/mobx.dart';

part 'tag.g.dart';

class Tag = _Tag with _$Tag;

abstract class _Tag with Store {
  @observable
  String id;

  @observable
  String title;

  @observable
  String description;

  final DateTime createdAt;

  @observable
  DateTime updatedAt;

  _Tag({this.id, this.description, this.title, this.updatedAt, this.createdAt});

  _Tag.fromJson(Map<String, dynamic> json)
      : description = json['description'],
        title = json['title'],
        createdAt = DateTime.parse(json['createdAt']),
        updatedAt = DateTime.parse(json['updatedAt']);

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'title': title,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
