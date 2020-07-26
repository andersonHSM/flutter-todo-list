// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_item.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TodoItem on _TodoItem, Store {
  final _$idAtom = Atom(name: '_TodoItem.id');

  @override
  String get id {
    _$idAtom.reportRead();
    return super.id;
  }

  @override
  set id(String value) {
    _$idAtom.reportWrite(value, super.id, () {
      super.id = value;
    });
  }

  final _$titleAtom = Atom(name: '_TodoItem.title');

  @override
  String get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  final _$descriptionAtom = Atom(name: '_TodoItem.description');

  @override
  String get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  final _$updatedAtAtom = Atom(name: '_TodoItem.updatedAt');

  @override
  DateTime get updatedAt {
    _$updatedAtAtom.reportRead();
    return super.updatedAt;
  }

  @override
  set updatedAt(DateTime value) {
    _$updatedAtAtom.reportWrite(value, super.updatedAt, () {
      super.updatedAt = value;
    });
  }

  final _$filedAtom = Atom(name: '_TodoItem.filed');

  @override
  bool get filed {
    _$filedAtom.reportRead();
    return super.filed;
  }

  @override
  set filed(bool value) {
    _$filedAtom.reportWrite(value, super.filed, () {
      super.filed = value;
    });
  }

  final _$finishedAtom = Atom(name: '_TodoItem.finished');

  @override
  bool get finished {
    _$finishedAtom.reportRead();
    return super.finished;
  }

  @override
  set finished(bool value) {
    _$finishedAtom.reportWrite(value, super.finished, () {
      super.finished = value;
    });
  }

  final _$_TodoItemActionController = ActionController(name: '_TodoItem');

  @override
  void toggleFiledState() {
    final _$actionInfo = _$_TodoItemActionController.startAction(
        name: '_TodoItem.toggleFiledState');
    try {
      return super.toggleFiledState();
    } finally {
      _$_TodoItemActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleFinishedState() {
    final _$actionInfo = _$_TodoItemActionController.startAction(
        name: '_TodoItem.toggleFinishedState');
    try {
      return super.toggleFinishedState();
    } finally {
      _$_TodoItemActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
id: ${id},
title: ${title},
description: ${description},
updatedAt: ${updatedAt},
filed: ${filed},
finished: ${finished}
    ''';
  }
}
