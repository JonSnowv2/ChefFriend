import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Map<String, dynamic>>> fetchData(String url) async{
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200){
    List<dynamic> data = json.decode(response.body);
    List<Map<String, dynamic>> recipes = data.cast<Map<String, dynamic>>();
    return recipes;
  }
  else{
    throw Exception("Failed to load recipes");
  }
}

Future<List<Map<String, dynamic>>> fetchRecipeData() async{
  const url = 'http://127.0.0.1:8081/api/recipes';

  return fetchData(url);
}

Future<void> deleteRecipe(int recipeId) async {
  final apiUrl = 'http://192.168.1.213:8081/api/recipes/$recipeId';

  try {
    final response = await http.delete(Uri.parse(apiUrl));

    if (response.statusCode == 204) {
    } else {
      print('Error deleting recipe. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error deleting recipe: $error');
  }
}

Future<void> createRecipe(String title, String description, List<String> ingredients, List<String> instructions, String category, String image) async {
  const url = 'http://127.0.0.1:8081/api/recipes/add';

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'title': title,
        'description': description,
        'ingredients': ingredients,
        'instructions': instructions,
        'category': category,
        'image': image,
      }),
    );

    if (response.statusCode == 200) {
      print('Recipe created successfully');
    } else {
      print('Error creating recipe. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error creating recipe: $error');
  }
}
