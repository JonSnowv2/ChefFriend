import 'dart:convert';
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'package:my_app/Service/recipe_service.dart';
import '../Classes/recipe.dart';
import '../Classes/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<bool> checkUserExists(username) async{
  final url = Uri.parse('http://127.0.0.1:8081/api/username_exists');
  final response = await http.post(
    url,
    body: {
      'username': username,
    }
  );

  if (response.statusCode == 200){
    final Map<String, dynamic> data = json.decode(response.body);

    bool exists = data['exists'];

    return exists;
  }
  else{
    throw Exception('Failed to check if username exists.');
  }
}

void storeToken(String token) async {
  html.window.localStorage['token'] = token;
}

void registerUser(String username, String name, String password) async {
  final url = Uri.parse('http://127.0.0.1:8081/register');
  final response = await http.post(
    url,
    body: {
      'username': username,
      'name': name,
      'password': password,
    },
  );

  if (response.statusCode == 200) {
    print('Registration successful');
  } else {
    print('Registration failed: ${response.body}');
  }
}

Future<User?> loginUser(String username, String password) async {
  final url = Uri.parse('http://127.0.0.1:8081/login');

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final dynamic responseData = json.decode(response.body);

      if (responseData is Map<String, dynamic> && responseData.containsKey('user')) {
        final user = User.fromJson(responseData['user']);

        // Store the token if available
        if (responseData.containsKey('access_token')) {
          final token = responseData['access_token'].toString();
          storeToken(token);
        }

        return user;
      } else {
        print('Invalid response format from the server.');
      }
    } else {
      print('Login failed with status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (e) {
    print('Error during login: $e');
  }

  return null;
}

Future<User?> fetchUserData(String token) async {
  final url = Uri.parse('http://127.0.0.1:8081/api/return_user');
  print(token);
  try {
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final dynamic responseData = json.decode(response.body);

      if (responseData is Map<String, dynamic> && responseData.containsKey('user')) {
        return User.fromJson(responseData['user']);
      } else {
        print('Invalid response format from the server.');
      }
    } else {
      print('Failed to fetch user data with status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (e) {
    print('Error during fetching user data: $e');
  }

  return null;
}

Future<List<Map<String, dynamic>>?> fetchAnotherUsersData(String username) async {
  final url = Uri.parse('http://127.0.0.1:8081/api/return_user_recipes');

  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"}, // Set the content type
      body: json.encode({"username": username}), // Encode the request body as JSON
    );

    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data.containsKey('recipes') && data['recipes'] != null) {
        List<int> recipesIds = List<int>.from(data['recipes']);
        List<Map<String, dynamic>> recipes = await fetchRecipesById(recipesIds);
        return recipes;
      } else {
        throw Exception('Json is not correct');
      }
    } else {
      throw Exception('Error with the response: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('API request error: $e');
  }
}

Future<void> addToFavorites(int recipeId, String username) async{
  final url = Uri.parse('http://127.0.0.1:8081/api/add_to_favorites');

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: json.encode({'username': username, 'recipeId': recipeId})
  );

  if (response.statusCode == 200){
    print('Recipe added to Favorites');
  }
  else{
    print('Process failed');
  }
}

Future<void> getFavorites(String username) async{

}












