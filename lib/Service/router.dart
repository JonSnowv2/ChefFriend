

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/create_recipe.dart';
import 'package:my_app/favorites_page.dart';
import 'package:my_app/log_in_page.dart';
import 'package:my_app/public_recies_page.dart';
import 'package:my_app/unknown_page.dart';
import 'package:my_app/welcome_page.dart';

import '../homepage.dart';
import '../register_page.dart';

class MyAppRouter{

  GoRouter router = GoRouter(

    routes: [
      GoRoute(
          name: MyAppRouteConstants.defaultRouteName,
          path: '/',
          pageBuilder: (context, state){
            return MaterialPage(child: WelcomePage());
          }
      ),
      GoRoute(
        name: MyAppRouteConstants.registerRouteName,
        path: '/register',
        pageBuilder: (context, state){
          return MaterialPage(child: RegisterPage());
        }
      ),
      GoRoute(
          name: MyAppRouteConstants.loginRouteName,
          path: '/login',
          pageBuilder: (context, state){
            return MaterialPage(child: LogInPage());
          }
      ),
      GoRoute(
          name: MyAppRouteConstants.appRouteName,
          path: '/chefs_friend',
          pageBuilder: (context, state){
            return MaterialPage(child: HomePage());
          }
      ),
    ],
    errorPageBuilder: (context, state){
      return MaterialPage(child: UnknownPage());
    }

  );
}

class MyAppRouteConstants{
  static const String defaultRouteName = 'default';
  static const String registerRouteName = 'register';
  static const String loginRouteName = 'login';
  static const String appRouteName = 'chefs_friend';
}