import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoolTextBar extends StatefulWidget {
  TextEditingController Controller;
  String type;
  final FormFieldValidator<String>? validator;

  CoolTextBar({super.key, required this.Controller, required this.type, required this.validator});

  @override
  State<CoolTextBar> createState() => _CoolTextBarState();
}

class _CoolTextBarState extends State<CoolTextBar> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: 20),
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
      validator: widget.validator,
    );
  }
}
