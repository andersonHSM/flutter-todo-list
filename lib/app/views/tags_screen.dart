import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo/app/controllers/auth_controller.dart';
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
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    tagsController = Provider.of<TagsController>(context, listen: false);
    tagsRepository = Provider.of<TagsRepository>(context, listen: false);

    _fetchTags();
  }

  Future<void> _fetchTags() async {
    final tags = await tagsRepository.fetchTags();

    tagsController.setTags(tags);
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tags List'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.power_settings_new),
              onPressed: () {
                AuthController authController =
                    Provider.of(context, listen: false);
                authController.logout();
              })
        ],
      ),
      body: Observer(
        builder: (_) {
          List<Tag> tags = tagsController.tags.toList();

          if (_loading && tags.length == 0) {
            return Center(child: CircularProgressIndicator());
          }

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
