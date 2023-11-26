import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Service/recipe_service.dart';
import 'package:my_app/Service/user_service.dart';
import 'package:my_app/Styles/Colors.dart';
import 'package:my_app/Widgets/container_recipe_v2.dart';
import 'Styles/Shadows.dart';
import 'Classes/recipe.dart';
import 'Classes/user.dart';
import 'dart:html' as html;

class ProfilePage extends StatefulWidget {

  ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Recipe> recipeCopy = [];
  List<Recipe> fetchedRecipes = [];
  User? user;
  bool delayComplete = false;

  String? getToken() {
    return html.window.localStorage['token'];
  }

  Future<void> getReipesAndUser() async{
    String? token = getToken();

    user = await fetchUserData(token!);


    List<Map<String,dynamic>> recipeData = await fetchRecipeData(token);

    setState(() {
      fetchedRecipes = recipeFromJson(json.encode(recipeData));
    });

    print(fetchedRecipes);
  }

  void initializeData() async {
    await getReipesAndUser();
    setState(() {
      recipeCopy = List.from(fetchedRecipes);
    });
  }



  @override
  void initState(){
    super.initState();
    getReipesAndUser();
    initializeData();
    recipeCopy = fetchedRecipes;
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        delayComplete = true;
      });
    });
  }

  TextEditingController _searchController = TextEditingController();

  void _searchByTitle(){
    setState(() {
      recipeCopy = fetchedRecipes.where((recipe) => recipe.title.toLowerCase().contains(_searchController.text.toLowerCase())).toList();
    });
  }

  void _removeRecipe(Recipe recipe) {
    setState(() {
      recipeCopy.remove(recipe);
    });
  }

  @override
  Widget build(BuildContext context) {
    return delayComplete == true ? Scaffold(
      body: Container(
        color: White_Anti_Flash,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Text(
                "Hello, ${user!.name}",
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
    ): Center(child: CircularProgressIndicator(),);
  }
}
