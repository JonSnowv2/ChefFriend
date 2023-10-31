import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:my_app/Service/recipe_service.dart';
import 'package:my_app/Widgets/container_recipe_v2_noremove.dart';
import 'dart:html' as html;
import 'Classes/recipe.dart';

class PublicRecipePage extends StatefulWidget {
  PublicRecipePage({super.key});

  @override
  State<PublicRecipePage> createState() => _PublicRecipePageState();
}

class _PublicRecipePageState extends State<PublicRecipePage> {
  List<Recipe> recipes = [];
  bool isLoaded = false;

  String? getToken() {
    return html.window.localStorage['token'];
  }

  void getData() async {
    String? token = getToken();
    List<Map<String, dynamic>> recipeData = await fetchPublicRecipes(token!);

    setState(() {
      recipes = recipeFromJson(json.encode(recipeData));
      isLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded
        ? Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
          child: Column(
            children: [
              Row(
                children: [
                  TextButton(onPressed: () {}, child: Text('category')),
                  TextButton(
                      onPressed: () {}, child: Text('number of ingredients')),
                  TextButton(onPressed: () {}, child: Text('time taken')),
                ],
              ),
              SizedBox(height: 20), // Adjust the spacing as needed
              Wrap(
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
      ),
    )
        : Center(child: CircularProgressIndicator());
  }
}
