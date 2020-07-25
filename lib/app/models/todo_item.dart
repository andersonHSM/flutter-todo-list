import 'package:flutter/foundation.dart';

class TodoItem with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  bool filed;
  bool finished;

  TodoItem({
    @required this.title,
    this.id,
    this.description,
    this.filed = false,
    this.finished = false,
  });

  void toggleFiledState() {
    this.filed = !this.filed;
    notifyListeners();
  }

  void toggleFinishedState() {
    this.finished = !this.finished;
    notifyListeners();
  }
}
