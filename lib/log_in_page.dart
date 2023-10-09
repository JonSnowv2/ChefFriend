import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Service/user_service.dart';
import 'Service/user_service.dart';
import 'Widgets/input_text_create.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            TextBarCreateRecipe(Controller: usernameController, type: 'Username'),
            TextBarCreateRecipe(Controller: passwordController, type: 'Password'),
            TextButton(
                onPressed: () async {
                  final user = await loginUser(usernameController.text, passwordController.text);
                  if (user != null) {
                    Navigator.pushNamed(
                      context,
                      '/home',
                      arguments: user,
                    );
                  }
                },
                child: Text("Log In")
            )
          ],
        ),
      ),
    );
  }
}