import 'package:flutter/material.dart';
import 'package:my_app/register_page.dart';
import 'package:my_app/log_in_page.dart';
import 'package:my_app/homepage.dart';
import 'Service/user_service.dart';
import 'dart:html' as html;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final token = getTokenFromStorage();

    final initialRoute = token != null ? '/home' : '/register';

    return MaterialApp(
      title: 'My App',
      initialRoute: initialRoute,
      routes: {
        '/register': (context) => RegisterPage(),
        '/login': (context) => LogInPage(),
        '/home': (context) => HomePage(),
      },
    );
  }

  String? getTokenFromStorage() {
    String? token = html.window.localStorage['token'];
    if (token != null){
      return token;
    }
    else{
      return null;
    }
  }
}