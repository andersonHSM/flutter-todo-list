import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo/app/controllers/tags_controller.dart';

import 'package:todo/app/models/tag.dart';
import 'package:todo/repositories/tags_repository.dart';
import 'package:todo/widgets/tag/tags_list_widget.dart';

class TagsScreen extends StatefulWidget {
  @override
  _TagsScreenState createState() => _TagsScreenState();
}

class _TagsScreenState extends State<TagsScreen> {
  TagsController tagsController;
  TagsRepository tagsRepository;

  @override
  void initState() {
    super.initState();
    tagsController = Provider.of<TagsController>(context, listen: false);
    tagsRepository = TagsRepository();

    _fetchTags();
  }

  Future<void> _fetchTags() async {
    final tags = await tagsRepository.fetchTags();

    tagsController.setTags(tags);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tags List'),
      ),
      body: Observer(
        builder: (_) {
          List<Tag> tags = tagsController.tags.toList();

          return TagsListWidget(
            tags: tags,
            tagsRepository: tagsRepository,
            tagsController: tagsController,
          );
        },
      ),
    );
  }
}
