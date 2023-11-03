import 'dart:convert';

List<Recipe> recipeFromJson(String str){
  List<dynamic> jsonData = json.decode(str);

  return jsonData.map((json) => Recipe.fromJson(json)).toList();
}

class Recipe {
  int _id = 0;
  String _title = '';
  String _description = '';
  List<String> _instructions = [];
  List<String> _ingredients = [];
  String _category = '';
  String _image = '';
  String _user_username = '';
  int _public = 0;
  int _timeTaken = 0;

  Recipe({
    required id,
    required title,
    required description,
    required instructions,
    required ingredients,
    required category,
    required image,
    required user_username,
    required public,
    required timeTaken
  }):
      _id = id,
      _title = title,
      _description = description,
      _instructions = instructions,
      _ingredients = ingredients,
      _category = category,
      _image = image,
      _user_username = user_username,
      _public = public,
      _timeTaken = timeTaken;

  int get timeTaken => _timeTaken;

  set timeTaken(int value) {
    _timeTaken = value;
  }

  String get user_username => _user_username;

  set user_username(String value) {
    _user_username = value;
  }

  factory Recipe.fromJson(Map<String, dynamic> json){
    List<String> ingredientsList = json["ingredients"].split(',');
    List<String> instructionsList = json["instructions"].split(',');

    return Recipe(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      instructions: instructionsList,
      category: json["category"],
      image: json["image"],
      ingredients: ingredientsList,
      user_username: json['user_username'],
      public: json['public'],
      timeTaken: json['time_taken']
    );
  }


  int get public => _public;

  set public(int value) {
    _public = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  String get category => _category;

  set category(String value) {
    _category = value;
  }

  List<String> get ingredients => _ingredients;

  set ingredients(List<String> value) {
    _ingredients = value;
  }

  List<String> get instructions => _instructions;

  set instructions(List<String> value) {
    _instructions = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }
}




