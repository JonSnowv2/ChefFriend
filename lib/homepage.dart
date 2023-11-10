import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:my_app/Service/recipe_service.dart';
import 'package:my_app/create_recipe.dart';
import 'package:my_app/favorites_page.dart';
import 'package:my_app/public_recies_page.dart';
import 'Classes/recipe.dart';
import 'Classes/user.dart';
import 'Service/user_service.dart';
import 'profile_page.dart';
import 'dart:html' as html;

class HomePage extends StatefulWidget {
  final User? user;

  HomePage({Key? key, required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Recipe> recipes = [];
  bool dataFetched = false;

  String? getToken() {
    return html.window.localStorage['token'];
  }

  @override
  void initState() {
    super.initState();
    fetchAndSetRecipes();
  }

  Future<void> fetchAndSetRecipes() async {
    try {
      String? token = getToken();
      if (token != null) {
        List<Map<String, dynamic>> fetchedRecipeData = await fetchRecipeData(token);

        List<Recipe> fetchedRecipes = [];
        for (Map<String, dynamic> recipeMap in fetchedRecipeData) {
          Recipe recipe = Recipe.fromJson(recipeMap);
          fetchedRecipes.add(recipe);
        }
        setState(() {
          recipes = fetchedRecipes;
          dataFetched = true;
        });
      } else {
        print('Token is missing. Please log in.');
      }
    } catch (e) {
      print('Error fetching recipes: $e');
    }
  }

  Future<void> refreshRecipes() async {
    await fetchAndSetRecipes();
  }

  @override
  Widget build(BuildContext context) {
    if (!dataFetched)
      return Center(
        child: CircularProgressIndicator(),
      );
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
                  IconButton(onPressed: ()
                  {
                    refreshRecipes();
                  },
                      icon: Icon(Icons.refresh)),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Container(
                    child: ProfilePage(user: widget.user!, recipes: recipes),
                  ),
                  Container(
                    child: CreateActivityPage(),
                  ),
                  Container(
                    child: PublicRecipePage(),
                  ),
                  Container(
                    child: FavoritesPage(user: widget.user!),
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
