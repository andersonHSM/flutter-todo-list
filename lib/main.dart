import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app/controllers/tags_controller.dart';
import 'package:todo/app/controllers/todos_controller.dart';
import 'package:todo/app/views/todos_screen.dart';
import 'package:todo/utils/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<TodosController>(
          create: (_) => TodosController(),
        ),
        Provider<TagsController>(
          create: (_) => TagsController(),
        )
      ],
      child: MaterialApp(
        title: 'CoBlue ToDo List',
        theme: ThemeData(
          primaryColor: Colors.blueGrey[900],
          accentColor: Colors.deepPurple[700],
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // home: MyHomePage(title: 'ToDo List'),
        routes: {
          AppRoutes.HOME: (_) => TodosScreen(),
        },
      ),
    );
  }
}
