import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextBarCreateRecipe extends StatefulWidget {
  TextEditingController Controller;
  String type;

  TextBarCreateRecipe({super.key, required this.Controller, required this.type});

  @override
  State<TextBarCreateRecipe> createState() => _TextBarCreateRecipeState();
}

class _TextBarCreateRecipeState extends State<TextBarCreateRecipe> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: widget.type,
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
      controller: widget.Controller,
    );
  }
}
