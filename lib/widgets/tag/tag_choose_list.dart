import 'package:flutter/material.dart';
import 'package:todo/app/models/tag.dart';

class TagChooseList extends StatefulWidget {
  final List<Tag> tags;
  final int initialIndex;
  final Function(String) handleSelect;

  TagChooseList({
    @required this.tags,
    @required this.initialIndex,
    @required this.handleSelect,
  });

  @override
  _TagChooseListState createState() => _TagChooseListState();
}

class _TagChooseListState extends State<TagChooseList> {
  int _selectedIndex = 0;

  @override
  void initState() {
    widget.handleSelect(widget.tags.elementAt(_selectedIndex).id);
    _selectedIndex = widget.initialIndex;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: widget.tags.map((tag) {
        final index = widget.tags.indexOf(tag);

        return Container(
          margin: EdgeInsets.all(2),
          child: ChoiceChip(
            labelStyle: TextStyle(
                color: index == _selectedIndex ? Colors.white : Colors.black),
            selectedColor: Theme.of(context).accentColor,
            label: Text(tag.title),
            selected: index == _selectedIndex,
            onSelected: (isSelected) {
              widget.handleSelect(tag.id);

              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        );
      }).toList(),
    );
  }
}
