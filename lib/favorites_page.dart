import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Service/recipe_service.dart';
import 'package:my_app/Service/user_service.dart';

import 'Classes/recipe.dart';
import 'Classes/user.dart';
import 'Widgets/container_recipe_v2_noremove.dart';
import 'dart:html' as html;

class FavoritesPage extends StatefulWidget {

  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Recipe> recipes = [];
  bool isLoaded = false;
  User? user;

  String? getToken() {
    return html.window.localStorage['token'];
  }


  void getRecipes() async{
    final token = getToken();
    final List<dynamic>? recipeData = await fetchFavoriteRecipes(token!);

    setState(() {
      recipes = recipeFromJson(json.encode(recipeData));
    });
  }

  void fetchAndSetUser() async{
    String? token = getToken();

    user = await fetchUserData(token!);
  }

  @override
  void initState(){
    super.initState();
    fetchAndSetUser();
    getRecipes();
    print(recipes);
    isLoaded = true;
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded? Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            const Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Text('Your favorite recipes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 48),),
            ),
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    direction: Axis.horizontal,
                    children: recipes.map((recipe) {
                      String base64Image = recipe.image;
                      String dataUri = "data:image/jpeg;base64,$base64Image";
                      return ContainerRecipeV2Public(
                        recipe: recipe,
                        imageUrl: dataUri,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ): Center(child: CircularProgressIndicator(),);
  }
}
