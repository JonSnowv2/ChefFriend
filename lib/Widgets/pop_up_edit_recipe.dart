import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/Service/recipe_service.dart';
import 'package:my_app/Styles/Colors.dart';
import 'package:overlay_support/overlay_support.dart';

import '../Classes/recipe.dart';
import '../Styles/Shadows.dart';
import 'input_text_create.dart';
import 'input_text_create_v2expanded.dart';
import 'message_complete.dart';
import 'dart:html' as html;

class PopUpEditRecipe extends StatefulWidget {
  final Recipe recipe;
  final String? imageUrl;

  const PopUpEditRecipe({Key? key, required this.recipe, required this.imageUrl})
      : super(key: key);

  @override
  _PopUpEditRecipeState createState() => _PopUpEditRecipeState();
}

class _PopUpEditRecipeState extends State<PopUpEditRecipe> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _instructionsController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _timeTakenController = TextEditingController();
  Image? _selectedImage;
  String? _selectedImageBase64;
  bool isSwitched = false;

  List<String> ingredients = [];
  List<String> instructions = [];

  @override
  void initState(){
    super.initState();
    _titleController.text = widget.recipe.title;
    _descriptionController.text = widget.recipe.description;
    instructions = widget.recipe.instructions;
    ingredients = widget.recipe.ingredients;
    _timeTakenController.text = widget.recipe.timeTaken.toString();
    _selectedImage = Image.network(widget.imageUrl!);
    isSwitched = widget.recipe.public == 1 ? true : false;
  }

  void _updateIngredients(String ingredient){
    setState(() {
      ingredients.add(ingredient);
      _ingredientsController.clear();
    });
  }

  void _updateInstructions(String instruction){
    setState(() {
      instructions.add(instruction);
      _instructionsController.clear();
    });
  }

  Future<String?> selectAndConvertImage() async {
    final fileInput = html.FileUploadInputElement()
      ..accept = 'image/*';

    fileInput.click();

    await fileInput.onChange.first;

    final selectedFile = fileInput.files?.first;

    if (selectedFile != null) {
      final reader = html.FileReader();

      reader.readAsDataUrl(selectedFile);

      await reader.onLoad.first;

      final base64String = reader.result as String;

      return base64String;
    } else {
      return null;
    }
  }

  Future<String?> convertImageToBase64(html.File selectedFile) async {
    final reader = html.FileReader();
    reader.readAsDataUrl(selectedFile);
    await reader.onLoad.first;
    final base64String = reader.result as String;
    return base64String;
  }

  void _updateSelectedImage(String imageString) {
    final base64Image = imageString.split(',').last;

    setState(() {
      _selectedImage = Image.memory(
        base64Decode(base64Image),
        fit: BoxFit.cover,
        width: 640,
        height: 360,
      );
    });

    _selectedImageBase64 = base64Image;
  }

  void _onSubmit(String token){
      int public = isSwitched ? 1 : 0;
      String chefFriend = "Chef'sFriend";
      editRecipe(
          widget.recipe.id,
          _titleController.text,
          _descriptionController.text,
          ingredients,
          instructions,
          _selectedCategory!,
           token,
           public,
          int.parse(_timeTakenController.text)
      );
      showOverlayNotification((context) {
        return CompleteMessage(
          message: 'Recipe edited successfully',
        );
      });
      Navigator.of(context).pop();
      html.window.location.reload();
  }

  String? getToken() {
    return html.window.localStorage['token'];
  }

  String? _selectedCategory = 'Main Course';

  List<DropdownMenuItem<String>> categories = [
    DropdownMenuItem<String>(child: Text('Main Course'), value: 'Main Course'),
    DropdownMenuItem<String>(child: Text('Breakfast'), value: 'Breakfast'),
    DropdownMenuItem<String>(child: Text('Appetizer'), value: 'Appetizer'),
    DropdownMenuItem<String>(child: Text('Snack'), value: 'Snack'),
    DropdownMenuItem<String>(child: Text('Salad'), value: 'Salad'),
    DropdownMenuItem<String>(child: Text('Soup'), value: 'Soup'),
    DropdownMenuItem<String>(child: Text('Dessert'), value: 'Dessert'),
  ];

  void _updateSelectedCategory(String? newCategory) {
    if (newCategory != null) {
      setState(() {
        _selectedCategory = newCategory;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        content: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.8,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Edit this Recipe",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 48),
                                ),
                              ),
                              Row(
                                children: [
                                  Text('Make this recipe public?'),
                                  Switch(
                                      value: isSwitched,
                                      onChanged: (value){
                                        setState(() {
                                          isSwitched=value;
                                        });
                                      }
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        TextButton(
                            onPressed: (){
                              final token = getToken();
                              if (token != null) {
                                _onSubmit(token);
                              }
                            },
                            child: Text('Submit'),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  flex:3,
                                  child: CoolTextBar(
                                    Controller: _titleController,
                                    type: "Title",
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return "Please Enter a title";
                                      }
                                    },
                                  )
                              ),
                              SizedBox(
                                width: 50,
                              ),Expanded(
                                  flex: 1,
                                  child: CoolTextBar(
                                    Controller: _timeTakenController,
                                    type: "Time taken (minutes)",
                                    validator: (value){
                                      if (value!.isEmpty) {
                                        return 'Please enter a value';
                                      }
                                      try {
                                        int.parse(value);
                                        return null;
                                      } catch (e) {
                                        return 'Please enter a valid integer';
                                      }
                                    },
                                  )
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Expanded(
                                flex: 1,
                                child: DropdownButton<String>(
                                  items: categories,
                                  value: _selectedCategory,
                                  onChanged: (String? newValue) {
                                    _updateSelectedCategory(newValue);
                                  },
                                  iconSize: 42,
                                  iconEnabledColor: Persian_Orange,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 50,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 360,
                                      width: 640,
                                      color: Color(0xffefefef),
                                      child: _selectedImage != null
                                          ? _selectedImage
                                          : Placeholder(),
                                    ),
                                    TextButton(
                                        onPressed: () async {
                                          final imageString = await selectAndConvertImage();
                                          if (imageString != null) {
                                            _updateSelectedImage(imageString);
                                          }
                                        },
                                        child: Text("Replace Image")
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  height: 300,
                                  child: CoolTextBarv2(
                                    Controller: _descriptionController,
                                    type: "Description",
                                    validator: (value) {
                                      if (value!.length < 60) {
                                        return "Must be at least 60 characters!";
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 50,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    CoolTextBar(
                                      Controller: _ingredientsController,
                                      type: "Ingredients",
                                      validator: (value){

                                      },
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: TextButton(
                                        onPressed: () {
                                          _updateIngredients(_ingredientsController.text);
                                        },
                                        child: Text("Submit ingredient"),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: ingredients.map((ingredient) {
                                          return Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "- $ingredient",
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              IconButton(
                                                  onPressed: (){
                                                    setState(() {
                                                      ingredients.remove(ingredient);
                                                    });
                                                  },
                                                  icon: Icon(Icons.close)
                                              )
                                            ],
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  children: [
                                    CoolTextBar(
                                      Controller: _instructionsController,
                                      type: "Instructions",
                                      validator: (value){

                                      },
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: TextButton(
                                        onPressed: () {
                                          _updateInstructions(_instructionsController.text);
                                        },
                                        child: Text("Submit instruction"),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: instructions.map((instruction) {
                                          return Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "- $instruction",
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              IconButton(
                                                  onPressed: (){
                                                    setState(() {
                                                      instructions.remove(instruction);
                                                    });
                                                  },
                                                  icon: Icon(Icons.close)
                                              )
                                            ],
                                          );
                                        }).toList(),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
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
