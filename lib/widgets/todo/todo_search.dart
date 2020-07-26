import 'package:flutter/material.dart';
import 'package:todo/app/models/tag.dart';

class TodoSearch extends SearchDelegate<Tag> {
  final List<Tag> tags;

  TodoSearch({@required this.tags});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = "",
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Tag> sugestions = tags
        .where((tag) => tag.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: sugestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(sugestions[index].title),
          onTap: () => close(context, sugestions[index]),
        );
      },
    );
  }
}
