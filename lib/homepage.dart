import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/Service/recipe_service.dart';
import 'package:my_app/Styles/Colors.dart';
import 'package:my_app/create_recipe.dart';
import 'package:my_app/favorites_page.dart';
import 'package:my_app/public_recies_page.dart';
import 'package:my_app/unknown_page.dart';
import 'package:my_app/welcome_page.dart';
import 'Classes/recipe.dart';
import 'Classes/user.dart';
import 'Service/user_service.dart';
import 'profile_page.dart';
import 'dart:html' as html;
import 'Service/router.dart';

class HomePage extends StatefulWidget {

  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Recipe> recipes = [];
  bool dataFetched = false;
  User? user;

  String? getToken() {
    return html.window.localStorage['token'];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              color: Colors.deepOrange,
              child: Stack(
                children: [
                  TabBar(
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.white,
                    indicatorColor: Colors.blue,
                    tabs: [
                      Tab(icon: Icon(Icons.person), text: "Profile Page"),
                      Tab(icon: Icon(Icons.add), text: "Add Recipe"),
                      Tab(icon: Icon(Icons.home), text: "Recipes"),
                      Tab(icon: Icon(Icons.favorite), text: "Favorites"),
                    ],
                  ),
                  IconButton(
                      onPressed: () async{
                        String? token = getToken();
                        context.goNamed(MyAppRouteConstants.defaultRouteName);
                        await logoutUser(token!);
                      },
                      icon: Icon(Icons.logout)),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Container(
                    child: ProfilePage(),
                  ),
                  Container(
                    child: CreateActivityPage(),
                  ),
                  Container(
                    child: PublicRecipePage(),
                  ),
                  Container(
                    child: FavoritesPage(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}