import 'package:flutter/material.dart';
import 'package:my_app/Styles/Colors.dart';

import '../Classes/recipe.dart';
import '../Styles/Shadows.dart';

class PopUpRecipe extends StatelessWidget {
  final Recipe recipe;
  final String? imageUrl;

  const PopUpRecipe({super.key, required this.recipe, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        title: Text(recipe.title),
        content: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.6,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        children:[ imageUrl != null
                            ? Image.network(imageUrl!)
                            : Container(child: Text("Chef'sFriend"),),
                          SizedBox(height: 60,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      boxShadow: [shadowImage],
                                      borderRadius: BorderRadius.circular(20),
                                      color: White_Anti_Flash
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Category: ${recipe.category}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                  )
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      boxShadow: [shadowImage],
                                      borderRadius: BorderRadius.circular(20),
                                      color: White_Anti_Flash
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Time Taken: ${recipe.timeTaken.toString()} minutes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                  )
                              ),
                            ],
                          ),
                         ]
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      flex: 8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                boxShadow: [shadowImage],
                                borderRadius: BorderRadius.circular(20),
                                color: White_Anti_Flash
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text('Description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)
                                  ),
                                  Text(
                                    recipe.description,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 200, // Adjust the number of lines as needed
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 60,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    boxShadow: [shadowImage],
                                    borderRadius: BorderRadius.circular(20),
                                    color: White_Anti_Flash
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text('Ingredients: ${recipe.ingredients.length.toString()}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: recipe.ingredients
                                            .map((ingredient) => Text('- ${ingredient}'))
                                            .toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    boxShadow: [shadowImage],
                                    borderRadius: BorderRadius.circular(20),
                                    color: White_Anti_Flash
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text('Instructions: ${recipe.instructions.length.toString()}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: recipe.instructions
                                            .map((instruction) => Text('- ${instruction}'))
                                            .toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}
