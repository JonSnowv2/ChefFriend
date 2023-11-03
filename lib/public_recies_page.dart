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
  TextEditingController _searchControllerTitle = TextEditingController();
  TextEditingController _searchControllerUsername = TextEditingController();
  List<Recipe> recipeCopy = [];

  String? getToken() {
    return html.window.localStorage['token'];
  }

  void getData() async {
    String? token = getToken();
    List<Map<String, dynamic>> recipeData = await fetchPublicRecipes(token!);

    setState(() {
      recipes = recipeFromJson(json.encode(recipeData));
      recipeCopy = recipes;
      isLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  void _searchBySearch(){
    setState(() {
      List<Recipe> filteredByTitle = recipes.where((recipe) => recipe.title.toLowerCase().contains(_searchControllerTitle.text.toLowerCase())).toList();
      List<Recipe> filteredByUsername = filteredByTitle.where((recipe) => recipe.user_username.toLowerCase().contains(_searchControllerUsername.text.toLowerCase())).toList();
      recipeCopy = filteredByUsername;
    });
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 400,
                              child: TextFormField(
                                controller: _searchControllerTitle,
                                decoration: InputDecoration(
                                    hintText: 'Search by recipe title...'
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: (){
                                  _searchBySearch();
                                },
                                icon: Icon(Icons.search)
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 400,
                              child: TextFormField(
                                controller: _searchControllerUsername,
                                decoration: InputDecoration(
                                    hintText: 'Search by username...'
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: (){
                                  _searchBySearch();
                                },
                                icon: Icon(Icons.search)
                            )
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        TextButton(onPressed: () {}, child: Text('category', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),)),
                        TextButton(
                            onPressed: () {}, child: Text('number of ingredients', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),)),
                        TextButton(onPressed: () {}, child: Text('time taken', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
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
      ),
    )
        : Center(child: CircularProgressIndicator());
  }
}
