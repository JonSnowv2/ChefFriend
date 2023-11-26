import 'package:flutter/material.dart';
import 'package:my_app/Styles/Colors.dart';
import 'package:my_app/create_recipe.dart';
import 'package:my_app/favorites_page.dart';
import 'package:my_app/profile_page.dart';
import 'package:my_app/public_recies_page.dart';
import 'package:my_app/register_page.dart';
import 'package:my_app/log_in_page.dart';
import 'package:my_app/homepage.dart';
import 'package:overlay_support/overlay_support.dart';
import 'Classes/user.dart';
import 'Service/user_service.dart';
import 'dart:html' as html;
import 'Service/router.dart';


String? getToken() {
  return html.window.localStorage['token'];
}

void main() async {
  final myAppRouter = MyAppRouter();

  runApp(
    OverlaySupport(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(scaffoldBackgroundColor: White_Anti_Flash),
        routeInformationParser: myAppRouter.router.routeInformationParser,
        routerDelegate: myAppRouter.router.routerDelegate,
        routeInformationProvider: myAppRouter.router.routeInformationProvider,
      ),
    ),
  );
}