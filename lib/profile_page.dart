import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Widgets/container_recipe.dart';
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
  void _printRecipes() {
    for (var i = 0; i < widget.recipes.length; i++) {
      print(widget.recipes[i].title);
    }
  }

  void _removeRecipe(Recipe recipe){
    widget.recipes.remove(recipe);
    setState(() {});
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
              child: Text(
                "Hello, ${widget.user.username}",
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
                  ElevatedButton(
                    onPressed: () {},
                    child: Icon(Icons.add),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.recipes.length,
                  itemBuilder: (context, index) =>
                      ContainerRecipe(recipe: widget.recipes[index], Function: (){_removeRecipe(widget.recipes[index]);},)),
            )
          ],
        ),
      ),
    );
  }
}
