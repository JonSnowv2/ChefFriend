import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Classes/recipe.dart';
import 'Widgets/container_recipe_v2_noremove.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Recipe> recipes = [];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
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
    );
  }
}
