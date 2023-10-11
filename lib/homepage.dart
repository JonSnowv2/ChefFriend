import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:my_app/Service/recipe_service.dart';
import 'package:my_app/create_recipe.dart';
import 'Classes/recipe.dart';
import 'Classes/user.dart';
import 'Service/user_service.dart';
import 'profile_page.dart';
import 'dart:html' as html;

class HomePage extends StatefulWidget {

  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user;
  List<Recipe> recipes = [];
  bool dataFetched = false;

  String? getToken() {
    return html.window.localStorage['token'];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    String? token = html.window.localStorage['token'];
    print('Got the token: $token');
    if (token != null) {
      print('Token is not null');
      final userArgument = ModalRoute.of(context)?.settings.arguments;
      print('Got the userArgument: $userArgument');
      if (userArgument is User) {
        print('It is the user!');
        user = userArgument;
        print('It is ${user!.username}');
        retrieveTokenAndData();
        print('executed till the very end');
      }
    } else {
      print(' oh no, the token is null :(');
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  // Function to retrieve token from local storage and fetch data
  Future<void> retrieveTokenAndData() async {
    String? token = getToken();
    if (token != null) {
      final recipeData = await fetchRecipeData(token);
      setState(() {
        recipes = recipeFromJson(json.encode(recipeData));
        dataFetched = true;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    if (user == null) {
      // Handle the case when the user hasn't been loaded yet (e.g., during initialization)
      return RefreshProgressIndicator();
    }
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: null,
        body: Column(
          children: [
            Container(
              color: Colors.deepOrange,
              child: TabBar(
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.white,
                indicatorColor: Colors.blue,
                tabs: [
                  Tab(icon: Icon(Icons.person), text: "Profile Page"),
                  Tab(icon: Icon(Icons.add), text: "Add Recipe"),
                  Tab(icon: Icon(Icons.home), text: "Recipes"),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Container(
                    child: dataFetched
                        ? ProfilePage(user: user!, recipes: recipes)
                        : CircularProgressIndicator(), // Show a loading indicator until data is fetched
                  ),
                  Container(
                    child: Center(
                      child: CreateActivityPage(),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text("3RD TAB"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
