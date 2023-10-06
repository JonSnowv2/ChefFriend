import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Classes/recipe.dart';
import 'Service/recipe_service.dart';

class CreateActivityPage extends StatefulWidget {
  final Function(Recipe) addRecipe;

  const CreateActivityPage({super.key, required this.addRecipe});

  @override
  State<CreateActivityPage> createState() => _CreateActivityPageState();
}

class _CreateActivityPageState extends State<CreateActivityPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _instructionsController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _categoryController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xffefefef),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                        "Add a Recipe",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 48),
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () async {
                      final newRecipe = createRecipe(
                        _titleController.text,
                        _descriptionController.text,
                        ['Ingredient 1', 'Ingredient 2'],
                        "Steps",
                        _categoryController.text,
                        'Image URL',
                      );

                      await newRecipe;

                    },
                    child: Icon(Icons.add)
                )
              ],
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 80),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex:1,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Title',
                            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                            hintText: '...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(color: Colors.blue)
                            )
                          ),
                          controller: _titleController,
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Expanded(
                      flex: 1,
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Category',
                              labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                              hintText: '...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder:OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(color: Colors.blue)
                              )
                          ),
                          controller: _categoryController,
                        ),
                      ),
                    ],
                  ),
                  Container(
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Description',
                            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                            hintText: '...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(color: Colors.blue)
                            )
                        ),
                        controller: _descriptionController,
                      ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
