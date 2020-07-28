import 'package:mobx/mobx.dart';
import 'package:todo/app/models/tag.dart';

part 'tags_controller.g.dart';

class TagsController = _TagsController with _$TagsController;

abstract class _TagsController with Store {
  @observable
  ObservableList<Tag> tags = ObservableList.of([]);

  @action
  void setTags(List<Tag> tags) {
    this.tags = [...tags].asObservable();
  }

  @action
  void clearTags() {
    this.tags.clear();
  }

  @action
  void updateTag(Tag tag, int index) {
    tags[index] = tag;
  }

  @action
  void addTag(Tag tag, [int index]) {
    if (index != null) {
      tags.insert(index, tag);
    } else {
      tags.add(tag);
    }
  }

  @action
  void deleteTag(Tag tag) {
    tags.remove(tag);
  }
}
