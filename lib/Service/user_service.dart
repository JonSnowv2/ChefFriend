import 'dart:convert';
import 'dart:html' as html;
import 'package:http/http.dart' as http;
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



