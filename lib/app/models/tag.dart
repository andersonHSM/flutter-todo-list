import 'package:mobx/mobx.dart';

part 'tag.g.dart';

class Tag = _Tag with _$Tag;

abstract class _Tag with Store {
  @observable
  String id;

  @observable
  String title;

  final DateTime createdAt;

  @observable
  DateTime updatedAt;

  _Tag({this.id, this.title, this.updatedAt, this.createdAt});

  _Tag.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        createdAt = DateTime.parse(json['createdAt']),
        updatedAt = DateTime.parse(json['updatedAt']);

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
