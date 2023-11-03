import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Styles/Colors.dart';
import 'package:my_app/Widgets/container_recipe_v2.dart';
import 'Styles/Shadows.dart';
import 'Classes/recipe.dart';
import 'Classes/user.dart';

class ProfilePage extends StatefulWidget {
  final User user;
  List<Recipe> recipes;

  ProfilePage({Key? key, required this.user, required this.recipes}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Recipe> recipeCopy = [];

  @override
  void initState(){
    super.initState();
    recipeCopy = widget.recipes;
  }

  TextEditingController _searchController = TextEditingController();

  void _searchByTitle(){
    setState(() {
      recipeCopy = widget.recipes.where((recipe) => recipe.title.toLowerCase().contains(_searchController.text.toLowerCase())).toList();
    });
  }

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
            Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 25),
              child: Row(
                children: [
                  Container(
                    width: 400,
                    child: TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search...'
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: (){
                        _searchByTitle();
                      },
                      icon: Icon(Icons.search)
                  )
                ],
              ),
            ),
      Expanded(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Wrap(
              spacing: 20,
              runSpacing: 20,
              direction: Axis.horizontal,
              children: recipeCopy.map((recipe) {
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
          ],
        ),
      ),
          ],
        ),
      ),
    );
  }
}
