import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Widgets/container_recipe.dart';
import 'Styles/Shadows.dart';
import 'Classes/recipe.dart';
import 'Classes/user.dart';

class ProfilePage extends StatelessWidget {
  final User user;
  final List<Recipe> recipes;

  const ProfilePage({super.key, required this.user, required this.recipes});

  void _printRecipes(){
    for (var i = 0; i < recipes.length; i++){
      print(recipes[i].title);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Text("Hello, ${user.username}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 48),),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(50, 0, 50, 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("My Recipes", style: TextStyle(fontSize: 32),),
                  ElevatedButton(
                    onPressed: (){},
                    child: Icon(Icons.add),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: recipes.length,
                  itemBuilder: (context, index) =>
                      ContainerRecipe(recipe: recipes[index])
              ),
            )
          ]
        ),
      ),
    );
  }
}
