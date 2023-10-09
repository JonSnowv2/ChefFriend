import 'package:flutter/material.dart';
import 'package:my_app/register_page.dart';
import 'package:my_app/log_in_page.dart';
import 'package:my_app/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      initialRoute: '/register', // Set the initial route
      routes: {
        '/register': (context) => RegisterPage(),
        '/login': (context) => LogInPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
