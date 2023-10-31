import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Styles/Colors.dart';
import 'package:my_app/Widgets/container_recipe_v2.dart';
import 'Styles/Shadows.dart';
import 'Classes/recipe.dart';
import 'Classes/user.dart';

class ProfilePage extends StatefulWidget {
  final User user;
  final List<Recipe> recipes;

  const ProfilePage({Key? key, required this.user, required this.recipes}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void _removeRecipe(Recipe recipe) {
    setState(() {
      widget.recipes.remove(recipe);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: White_Anti_Flash,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Text(
                "Hello, ${widget.user.name}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 48),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(50, 0, 50, 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My Recipes",
                    style: TextStyle(fontSize: 32),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 20,
                  direction: Axis.horizontal,
                  children: widget.recipes.map((recipe) {
                    String base64Image = recipe.image;
                    String dataUri = "data:image/jpeg;base64,$base64Image";
                    return ContainerRecipeV2(
                      recipe: recipe,
                      Function: () {
                        _removeRecipe(recipe);
                      },
                      imageUrl: dataUri,
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
