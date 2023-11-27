import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoolTextBarv2 extends StatefulWidget {
  TextEditingController Controller;
  String type;
  final FormFieldValidator<String>? validator;

  CoolTextBarv2({super.key, required this.Controller, required this.type, required this.validator});

  @override
  State<CoolTextBarv2> createState() => _CoolTextBarStatev2();
}

class _CoolTextBarStatev2 extends State<CoolTextBarv2> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: 20),
      maxLines: double.maxFinite.floor(),
      decoration: InputDecoration(
          alignLabelWithHint: true,
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
