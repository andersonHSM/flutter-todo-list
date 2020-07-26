// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tags_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TagsController on _TagsController, Store {
  final _$tagsAtom = Atom(name: '_TagsController.tags');

  @override
  ObservableList<Tag> get tags {
    _$tagsAtom.reportRead();
    return super.tags;
  }

  @override
  set tags(ObservableList<Tag> value) {
    _$tagsAtom.reportWrite(value, super.tags, () {
      super.tags = value;
    });
  }

  final _$_TagsControllerActionController =
      ActionController(name: '_TagsController');

  @override
  void setTags(List<Tag> tags) {
    final _$actionInfo = _$_TagsControllerActionController.startAction(
        name: '_TagsController.setTags');
    try {
      return super.setTags(tags);
    } finally {
      _$_TagsControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateTag(Tag tag, int index) {
    final _$actionInfo = _$_TagsControllerActionController.startAction(
        name: '_TagsController.updateTag');
    try {
      return super.updateTag(tag, index);
    } finally {
      _$_TagsControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addTag(Tag tag, [int index]) {
    final _$actionInfo = _$_TagsControllerActionController.startAction(
        name: '_TagsController.addTag');
    try {
      return super.addTag(tag, index);
    } finally {
      _$_TagsControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteTag(Tag tag) {
    final _$actionInfo = _$_TagsControllerActionController.startAction(
        name: '_TagsController.deleteTag');
    try {
      return super.deleteTag(tag);
    } finally {
      _$_TagsControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tags: ${tags}
    ''';
  }
}
