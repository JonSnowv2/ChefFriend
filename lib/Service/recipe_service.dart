import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


Future<List<Map<String, dynamic>>> fetchRecipeData(String token) async {
  String url = 'http://192.168.1.213:8081/api/recipes';
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    List<Map<String, dynamic>> recipes = data.cast<Map<String, dynamic>>();
    return recipes;
  } else {
    throw Exception("Failed to load recipes");
  }
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

Future<void> createRecipe(String title, String description, List<String> ingredients, List<String> instructions, String category, String image, String token) async {
  const url = 'http://127.0.0.1:8081/api/recipes/add';

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
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

