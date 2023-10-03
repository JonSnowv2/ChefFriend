import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Classes/recipe.dart';
import 'Classes/user.dart';
import 'profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    User user = User(username: "Darius", password: "Cascador22", recipies: [1, 2]);
    List<Recipe> recipes = [
      Recipe(
        title: "Spaghetti Bologna",
        description: "This is my new recipe I am very proud",
        ingredients: ["1 tbsp olive oil", "4 rashers smoked streaky bacon, finely chopped", "2 medium onions, finely chopped", "2 carrots, trimmed and finely chopped", "2 celery sticks, finely chopped", "2 garlic cloves finely chopped", "2-3 sprigs rosemary leaves picked and finely chopped", "500g beef mince"],
        category: "Main Course",
        image: "image",
        instructions: "These are the instructions"
      ),
      Recipe(
          title: "Spaghetti Bologna",
          description: "This is my new recipe I am very proud",
          ingredients: ["1 tbsp olive oil", "4 rashers smoked streaky bacon, finely chopped", "2 medium onions, finely chopped", "2 carrots, trimmed and finely chopped", "2 celery sticks, finely chopped", "2 garlic cloves finely chopped", "2-3 sprigs rosemary leaves picked and finely chopped", "500g beef mince"],
          category: "Main Course",
          image: "image",
          instructions: "These are the instructions"
      )
    ];

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
                Tab(icon: Icon(Icons.person), text: "Profile Page",),
                Tab(icon: Icon(Icons.add), text: "Add Recipe"),
                Tab(icon: Icon(Icons.home), text: "Recipes"),
              ],
              ),
            ),
            Expanded(
              child: TabBarView(
                  children: [
                    Container(
                        child: ProfilePage(user: user, recipes: recipes)
                    ),
                    Container(
                      child: Center(
                        child: Text("2ND TAB"),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text("3ST TAB"),
                      ),
                    ),
                  ]
              ),
            )
          ]
        ),
      ),
    );
  }
}
