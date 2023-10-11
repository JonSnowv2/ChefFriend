import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:my_app/Widgets/input_text_create.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Classes/recipe.dart';
import 'Service/recipe_service.dart';
import 'Service/user_service.dart';

class CreateActivityPage extends StatefulWidget {
  final AuthService authService;


  const CreateActivityPage({super.key, required this.authService});

  @override
  State<CreateActivityPage> createState() => _CreateActivityPageState();
}

class _CreateActivityPageState extends State<CreateActivityPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _instructionsController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _categoryController = TextEditingController();
  Image? _selectedImage;
  String? _selectedImageBase64;

  List<String> ingredients = [];
  List<String> instructions = [];

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

  void _onSubmit(String? token) {
    if (_selectedImageBase64 != null) {
      createRecipe(
        _titleController.text,
        _descriptionController.text,
        ingredients,
        instructions,
        _categoryController.text,
        _selectedImageBase64!,
        token!,
      );
      html.window.location.reload();
    }
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery. of(context). size. width;
    return Scaffold(
      body: Container(
        color: Color(0xffefefef),
        child: SingleChildScrollView(
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
                      onPressed: () async{
                        final token = await widget.authService.getToken();
                        if (token != null) {
                          _onSubmit(token!);
                        }
                        },
                      child: Icon(Icons.add)
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
                          flex:1,
                          child: TextBarCreateRecipe(Controller: _titleController, type: "Title",)
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Expanded(
                        flex: 1,
                            child: TextBarCreateRecipe(Controller: _categoryController, type: "Category",)
                        ),
                      ],
                    ),
                    SizedBox(height: 50,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              TextBarCreateRecipe(Controller: _ingredientsController, type: "Ingredients",),
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
                                    return Text(
                                      "- $ingredient",
                                      style: TextStyle(fontSize: 18),
                                    );
                                  }).toList(),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Expanded(
                          flex: 2,
                          child: TextBarCreateRecipe(Controller: _descriptionController, type: "Description",)
                        ),
                      ],
                    ),
                  Row(
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
                                child: Text("Add Image")
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            TextBarCreateRecipe(Controller: _instructionsController, type: "Instructions",),
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
                                children: instructions.map((instructions) {
                                  return Text(
                                    "- $instructions",
                                    style: TextStyle(fontSize: 18),
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
    );
  }
}
