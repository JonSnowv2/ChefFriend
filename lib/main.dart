import 'package:flutter/material.dart';
import 'package:my_app/Styles/Colors.dart';
import 'package:my_app/register_page.dart';
import 'package:my_app/log_in_page.dart';
import 'package:my_app/homepage.dart';
import 'package:overlay_support/overlay_support.dart';
import 'Classes/user.dart';
import 'Service/user_service.dart';
import 'dart:html' as html;


String? getToken() {
  return html.window.localStorage['token'];
}

void main() async {
  String? token = getToken();
  User? user;

  if (token != null){
    user = await fetchUserData(token);
    print('yes');
  }

  if(user != null){
    print(user.username);
  }
  else{
    print('IT IS NULL');
  }


  runApp(OverlaySupport(
    child: MaterialApp(
        theme: new ThemeData(scaffoldBackgroundColor: White_Anti_Flash),
      home: token == null ? RegisterPage() : HomePage(user: user)
    )
  ));
}