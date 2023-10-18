import 'dart:convert';

List<User> userFromJson(String str){
  List<dynamic> jsonData = json.decode(str);

  return jsonData.map((json) => User.fromJson(json)).toList();
}

class User{
  String _username = '';
  String _name = '';
  String _password = '';
  List<dynamic> _recipes = [];

  User({
    required username,
    required password,
    required recipes,
    required name
  }):
      _username = username,
      _password = password,
      _recipes = recipes,
      _name = name;

  factory User.fromJson(Map<String, dynamic> json){

    final recipesData = json['recipes'];
    List<int> recipes = [];

    if (recipesData is List) {
      recipes = recipesData.cast<int>();
    }

    return User(
      username: json['username'] ?? '',
      name: json['name'] ?? '',
      password: json['password'] ?? '',
      recipes: recipes,
    );
  }

  List<dynamic> get recipes => _recipes;

  set recipes(List<dynamic> value) {
    _recipes = value;
  }

  List<int> get recipesAsInt {
    return _recipes.map((recipe) => recipe as int).toList();
  }

  String get password => _password;

  set password(String value) {
    _password = value;
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