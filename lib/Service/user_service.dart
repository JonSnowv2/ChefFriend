import 'dart:convert';
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import '../Classes/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
    final userData = json.decode(response.body);

    final user = User.fromJson(userData);

    final token = userData['access_token'];
    if (token != null) {
      storeToken(token);
    }

    return user;
  } else {
    print('Login failed: ${response.body}');
    return null;
  }
}
