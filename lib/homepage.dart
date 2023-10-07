import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Service/recipe_service.dart';
import 'package:my_app/create_recipe.dart';
import 'Classes/recipe.dart';
import 'Classes/user.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User user = User(username: "Darius", password: "Cascador22", recipies: [1, 2]);
  List<Recipe> recipes = [];

  @override
  void initState(){
    super.initState();
    getData();
  }

  Future<void> getData() async{
    final recipeData = await fetchRecipeData();
    setState(() {
      recipes = recipeFromJson(json.encode(recipeData));
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: null,
        body: Column(
            children: [
              Container(
                color: Colors.deepOrange,
                child: TabBar(
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.white,
                  indicatorColor: Colors.blue,
                  tabs: [
                    Tab(icon: Icon(Icons.person), text: "Profile Page",),
                    Tab(icon: Icon(Icons.add), text: "Add Recipe"),
                    Tab(icon: Icon(Icons.home), text: "Recipes"),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                    children: [
                      Container(
                          child: ProfilePage(user: user, recipes: recipes)
                      ),
                      Container(
                        child: Center(
                          child: CreateActivityPage(),
                        ),
                      ),
                      Container(
                        child: Center(
                          child: Text("3ST TAB"),
                        ),
                      ),
                    ]
                ),
              )
            ]
        ),
      ),
    );
  }
}
