import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:my_app/Service/recipe_service.dart';
import 'package:my_app/Styles/Colors.dart';
import 'package:my_app/Widgets/container_recipe_v2_noremove.dart';
import 'dart:html' as html;
import 'Classes/recipe.dart';
import 'Classes/user.dart';

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

  String? _selectedCategory = 'All Categories';

  List<DropdownMenuItem<String>> categories = [
    DropdownMenuItem<String>(child: Text('All Categories'), value: 'All Categories'),
    DropdownMenuItem<String>(child: Text('Main Course'), value: 'Main Course'),
    DropdownMenuItem<String>(child: Text('Breakfast'), value: 'Breakfast'),
    DropdownMenuItem<String>(child: Text('Appetizer'), value: 'Appetizer'),
    DropdownMenuItem<String>(child: Text('Snack'), value: 'Snack'),
    DropdownMenuItem<String>(child: Text('Salad'), value: 'Salad'),
    DropdownMenuItem<String>(child: Text('Soup'), value: 'Soup'),
    DropdownMenuItem<String>(child: Text('Dessert'), value: 'Dessert'),
  ];


  String _selectedTimeTaken = 'Any Time Taken';

  List<DropdownMenuItem<String>> timeTakenOptions = [
    DropdownMenuItem<String>(child: Text('Any Time Taken'), value: 'Any Time Taken'),
    DropdownMenuItem<String>(child: Text('5-10 minutes'), value: '5-10 minutes'),
    DropdownMenuItem<String>(child: Text('10-20 minutes'), value: '10-20 minutes'),
    DropdownMenuItem<String>(child: Text('20-30 minutes'), value: '20-30 minutes'),
    DropdownMenuItem<String>(child: Text('30-60 minutes'), value: '30-60 minutes'),
    DropdownMenuItem<String>(child: Text('60+ minutes'), value: '60+ minutes'),
  ];

  void _updateSelectedCategory(String? newCategory) {
    if (newCategory != null) {
      setState(() {
        _selectedCategory = newCategory;
      });
    }
  }

  void _updateSelectedTimeTaken(String? newTimeTakenValue) {
    if (newTimeTakenValue != null) {
      setState(() {
        _selectedTimeTaken = newTimeTakenValue;
      });
    }
  }

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
      List<Recipe> filteredByCategory = _selectedCategory != 'All Categories' ? filteredByUsername.where((recipe) => recipe.category == _selectedCategory).toList() : filteredByUsername;
      List<Recipe> filteredByTimeTaken = filteredByCategory;
      if (_selectedTimeTaken != 'Any Time Taken'){
        if(_selectedTimeTaken != '60+ minutes') {
          String firstBoundry = _selectedTimeTaken[1] != '-'
              ? _selectedTimeTaken[0] + _selectedTimeTaken[1]
              : _selectedTimeTaken[0];
          String secondBoundry = _selectedTimeTaken[1] != '-'
              ? _selectedTimeTaken[3] + _selectedTimeTaken[4]
              : _selectedTimeTaken[2] + _selectedTimeTaken[3];
          int firstBoundryInt = int.parse(firstBoundry);
          int secondBoundryInt = int.parse(secondBoundry);

          filteredByTimeTaken = filteredByCategory.where((recipe) => recipe.timeTaken >= firstBoundryInt && recipe.timeTaken <= secondBoundryInt).toList();
        }
        else{
          filteredByTimeTaken = filteredByCategory.where((recipe) => recipe.timeTaken >= 60).toList();
        }

      }
      recipeCopy = filteredByTimeTaken;
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownButton<String>(
                          items: categories,
                          value: _selectedCategory,
                          onChanged: (String? newValue) {
                            _updateSelectedCategory(newValue);
                            _searchBySearch();
                          },
                          iconSize: 42,
                          iconEnabledColor: Persian_Orange,
                        ),
                        SizedBox(width: 50,),
                        DropdownButton<String>(
                          items: timeTakenOptions,
                          value: _selectedTimeTaken,
                          onChanged: (String? newValue) {
                            _updateSelectedTimeTaken(newValue);
                            _searchBySearch();
                          },
                          iconSize: 42,
                          iconEnabledColor: Persian_Orange,
                        ),
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
