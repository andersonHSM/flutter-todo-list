import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:todo/app/models/fab_bottom_app_bar_item.dart';
import 'package:todo/app/views/tags_screen.dart';
import 'package:todo/app/views/todos_screen.dart';
import 'package:todo/widgets/navigation/fab_bottom_app_bar.dart';
import 'package:todo/widgets/tag_form_widget.dart';
import 'package:todo/widgets/todo_form_widget.dart';

enum FormsModals { TODO, TAG }

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [TodosScreen(), TagsScreen()];

  Future<void> _openFormDialog(FormsModals modal) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        switch (modal) {
          case FormsModals.TAG:
            return TagFormWidget();
          // case FormsModals.TODO:
          //   return TodoFormWidget();
          default:
            return TodoFormWidget();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens.elementAt(_currentIndex),
      bottomNavigationBar: FABBottomAppBar(
        activeColor: Theme.of(context).accentColor,
        items: [
          FABBottomAppBarItem(icon: Icons.assignment, text: 'ToDos'),
          FABBottomAppBarItem(icon: Icons.local_offer, text: 'Tags'),
        ],
        handleIconTap: (index) => setState(() {
          _currentIndex = index;
        }),
        currentIndex: _currentIndex,
      ),
      floatingActionButton: SpeedDial(
        shape: CircleBorder(),
        child: Icon(Icons.add),
        children: [
          SpeedDialChild(
            label: 'ToDo',
            child: Icon(Icons.assignment),
            onTap: () => _openFormDialog(FormsModals.TODO),
          ),
          SpeedDialChild(
              label: 'Tag',
              child: Icon(Icons.local_offer),
              onTap: () => _openFormDialog(FormsModals.TAG))
        ],
      ),
    );
  }
}
