import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:todo/app/controllers/tags_controller.dart';
import 'package:todo/app/models/tag.dart';
import 'package:todo/repositories/tags_repository.dart';
import 'package:todo/widgets/tag_form_widget.dart';

class TagsListWidget extends StatelessWidget {
  final List<Tag> tags;
  final TagsRepository tagsRepository;
  final TagsController tagsController;

  TagsListWidget({
    @required this.tags,
    @required this.tagsRepository,
    @required this.tagsController,
  });

  Future<bool> _showDeleteDialog(BuildContext context) async {
    final bool shouldDelete = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Remove Tag?'),
          actions: <Widget>[
            RaisedButton(
              color: Theme.of(context).accentColor,
              child: Text('Confirm'),
              onPressed: () => Navigator.of(context).pop(true),
            )
          ],
        );
      },
    );

    if (shouldDelete == null) return false;

    return shouldDelete;
  }

  Future<void> _showBottomFormDialog(
      BuildContext context, Tag tag, int tagIndex) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return TagFormWidget(
          tag: tag,
          index: tagIndex,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final emptyMessage = Center(
      child: Text('No Tags found.'),
    );

    if (tags.length == 0) {
      return emptyMessage;
    }

    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.6,
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Wrap(
          alignment: WrapAlignment.center,
          children: tags.map(
            (tag) {
              int index = tags.indexOf(tag);

              return Observer(
                builder: (_) => Container(
                  margin: EdgeInsets.all(5),
                  child: GestureDetector(
                    onLongPress: () async {
                      final shouldDelete = await _showDeleteDialog(context);

                      if (shouldDelete) {
                        try {
                          tagsController.deleteTag(tag);

                          await tagsRepository.deleteTag(tag);
                        } catch (e) {
                          tagsController.addTag(tag, index);
                        }
                      }
                    },
                    child: ActionChip(
                      onPressed: () async {
                        await _showBottomFormDialog(context, tag, index);
                      },
                      label: Text(tag.title),
                    ),
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
