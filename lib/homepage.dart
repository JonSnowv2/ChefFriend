import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:my_app/Service/recipe_service.dart';
import 'package:my_app/create_recipe.dart';
import 'Classes/recipe.dart';
import 'Classes/user.dart';
import 'Service/user_service.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {

  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User user = User(username: "Darius", password: "Cascador22", recipes: [1, 2], name: "User");
  List<Recipe> recipes = [];
  bool dataFetched = false;

  Future<void> getData() async {
    if (!dataFetched) {
      String? token = await widget.authService.getToken();
      final recipeData = await fetchRecipeData(token!);
      setState(() {
        recipes = recipeFromJson(json.encode(recipeData));
        dataFetched = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    user = ModalRoute.of(context)?.settings.arguments as User;
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
                    child: FutureBuilder(
                      future: getData(), // Use the fetched data here
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          // While fetching data
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          // Handle errors
                          return Text("Error: ${snapshot.error}");
                        } else {
                          // Display data when fetched
                          return ProfilePage(user: user, recipes: recipes);
                        }
                      },
                    ),
                  ),
                  Container(
                    child: Center(
                      child: CreateActivityPage(authService: widget.authService),
                    ),
                  ),
                Container(
                  child: Center(
                    child: Text("3ST TAB"),
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
