import 'dart:convert';

List<User> userFromJson(String str){
  List<dynamic> jsonData = json.decode(str);

  return jsonData.map((json) => User.fromJson(json)).toList();
}

class User{
  String _username = '';
  String _name = '';
  List<dynamic> _recipes = [];
  List<dynamic> _favoriteRecipes = [];

  User({
    required username,
    required recipes,
    required name,
    required favoriteRecipes
  }):
      _username = username,
      _recipes = recipes,
      _name = name,
      _favoriteRecipes = favoriteRecipes;

  List<dynamic> get favoriteRecipes => _favoriteRecipes;

  set favoriteRecipes(List<dynamic> value) {
    _favoriteRecipes = value;
  }

  factory User.fromJson(Map<String, dynamic> json){

    final recipesData = json['recipes'];
    List<int> recipes = [];

    if (recipesData is List) {
      recipes = recipesData.cast<int>();
    }

    final favoriteRecipeIdsData = json['favorites_list'];
    List<int> favoriteRecipeIds = [];

    if (favoriteRecipeIdsData is List) {
      favoriteRecipeIds = favoriteRecipeIdsData.cast<int>();
    }

      return User(
      username: json['username'] ?? '',
      name: json['name'] ?? '',
      recipes: recipes,
      favoriteRecipes: favoriteRecipeIds
    );
  }

  List<dynamic> get recipes => _recipes;

  set recipes(List<dynamic> value) {
    _recipes = value;
  }

  List<int> get recipesAsInt {
    return _recipes.map((recipe) => recipe as int).toList();
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get username => _username;

  set username(String value) {
    _username = value;
  }
}