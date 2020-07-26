import 'package:flutter/material.dart';
import 'package:todo/app/models/fab_bottom_app_bar_item.dart';

class FABBottomAppBar extends StatefulWidget {
  final List<FABBottomAppBarItem> items;
  final Function(int) handleIconTap;
  final int currentIndex;
  final Color activeColor;
  final Color disabledColor;

  FABBottomAppBar({
    @required this.items,
    @required this.handleIconTap,
    @required this.currentIndex,
    this.activeColor,
    this.disabledColor,
  });

  @override
  _FABBottomAppBarState createState() => _FABBottomAppBarState();
}

class _FABBottomAppBarState extends State<FABBottomAppBar> {
  List<Widget> _buildIcons(List<FABBottomAppBarItem> items) {
    final activeColor = widget.activeColor ?? Theme.of(context).primaryColor;
    final disabledColor = widget.disabledColor ?? Colors.grey[600];

    return items.map((item) {
      final itemIndex = widget.items.indexOf(item);
      Color currentColor = disabledColor;

      if (itemIndex == widget.currentIndex) {
        currentColor = activeColor;
      }

      return RawMaterialButton(
        constraints: BoxConstraints(
          maxHeight: 80,
          maxWidth: 80,
          minHeight: 60,
          minWidth: 60,
        ),
        onPressed: () {
          widget.handleIconTap(itemIndex);
        },
        shape: CircleBorder(),
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(item.icon, color: currentColor),
            FittedBox(
                alignment: Alignment.center,
                child: Text(
                  item.text,
                  style: TextStyle(color: currentColor),
                )),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Container(
        height: 70,
        // padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _buildIcons(widget.items),
        ),
      ),
    );
  }
}
