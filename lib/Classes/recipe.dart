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

  Recipe({
    required id,
    required title,
    required description,
    required instructions,
    required ingredients,
    required category,
    required image
  }):
      _id = id,
      _title = title,
      _description = description,
      _instructions = instructions,
      _ingredients = ingredients,
      _category = category,
      _image = image;

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
    );
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




