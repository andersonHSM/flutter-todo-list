import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo/app/controllers/auth_controller.dart';
import 'package:todo/app/views/auth_screen.dart';
import 'package:todo/app/views/main_screen.dart';

class AuthOrHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthController auth = Provider.of(context, listen: false);

    return FutureBuilder(
      future: auth.tryAutoLogin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.error != null) {
          return Center(
            child: Text('Ocorreu um erro'),
          );
        } else {
          return Observer(
            builder: (context) {
              return auth.isAuthenticated ? MainScreen() : AuthScreen();
            },
          );
        }
      },
    );
  }
}
