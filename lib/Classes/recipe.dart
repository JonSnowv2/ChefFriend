
class Recipe {
  String _title = '';
  String _description = '';
  String _instructions = '';
  List<String> _ingredients = [];
  String _category = '';
  String _image = '';

  Recipe({
    required title,
    required description,
    required instructions,
    required ingredients,
    required category,
    required image
  }):
      _title = title,
      _description = description,
      _instructions = instructions,
      _ingredients = ingredients,
      _category = category,
      _image = image;


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

  String get instructions => _instructions;

  set instructions(String value) {
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




