import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo/app/controllers/tags_controller.dart';
import 'package:todo/app/models/tag.dart';
import 'package:todo/repositories/tags_repository.dart';
import 'package:todo/utils/form_validations.dart';
import 'package:todo/widgets/shared/form_actions.dart';

class TagFormWidget extends StatefulWidget {
  final Tag tag;
  final int index;

  TagFormWidget({this.tag, this.index});

  @override
  _TagFormWidgetState createState() => _TagFormWidgetState();
}

class _TagFormWidgetState extends State<TagFormWidget> {
  TagsController tagsController;
  TagsRepository tagsRepository;

  bool sendingRequest = false;
  final _form = GlobalKey<FormState>();
  final _descriptionFocusNode = FocusNode();

  final Map<String, dynamic> _formData = {};

  @override
  void initState() {
    super.initState();
    tagsController = Provider.of<TagsController>(context, listen: false);
    tagsRepository = Provider.of<TagsRepository>(context, listen: false);

    _formData['title'] = widget.tag?.title;
  }

  Future<void> _saveTag() async {
    final formState = _form.currentState;
    final isFormValid = formState.validate();

    if (!isFormValid) return;

    formState.save();

    final saveTime = DateTime.now();

    setState(() {
      sendingRequest = true;
    });

    try {
      Tag tag;
      Tag tagResponse;

      if (widget.tag == null) {
        tag = Tag(
          title: _formData['title'],
          createdAt: saveTime,
          updatedAt: saveTime,
        );

        tagResponse = await tagsRepository.saveTag(tag);
        tagsController.addTag(tagResponse);
      } else {
        Tag widgetTag = widget.tag;
        tag = Tag(
          title: widgetTag.title,
          createdAt: widgetTag.createdAt,
          id: widgetTag.id,
          updatedAt: widgetTag.updatedAt,
        );

        tag.updatedAt = saveTime;
        tag.title = _formData['title'];

        await tagsRepository.updateTag(tag);
        tagsController.updateTag(tag, widget.index);
      }

      Navigator.of(context).pop();
    } catch (e) {} finally {
      setState(() {
        sendingRequest = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Form(
          key: _form,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  onEditingComplete: () => _descriptionFocusNode.requestFocus(),
                  initialValue: widget.tag?.title ?? '',
                  onSaved: (value) => _formData['title'] = value,
                  decoration: InputDecoration(
                    labelText: 'Tag Title',
                    alignLabelWithHint: true,
                  ),
                  validator: (value) {
                    return FormValidators.requiredFieldValidator(value);
                  },
                ),
                SizedBox(height: 20),
                FormActions(
                  sendingRequest: sendingRequest,
                  saveFunction: _saveTag,
                )
              ],
            ),
          )),
    );
  }
}
