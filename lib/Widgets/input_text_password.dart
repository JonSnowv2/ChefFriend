import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoolTextBarPassword extends StatefulWidget {
  TextEditingController Controller;
  String type;
  final FormFieldValidator<String>? validator;

  CoolTextBarPassword({super.key, required this.Controller, required this.type, required this.validator});

  @override
  State<CoolTextBarPassword> createState() => _CoolTextBarPasswordState();
}

class _CoolTextBarPasswordState extends State<CoolTextBarPassword> {

  bool visible = false;

  void setVisibility(){
    setState(() {
      visible = !visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    Icon visibleIcon = visible ? Icon(Icons.visibility) : Icon(Icons.visibility_off);
    return Stack(
      children: [
        TextFormField(
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
          obscureText: !visible,
          controller: widget.Controller,
          validator: widget.validator,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
                onPressed: (){
                  setVisibility();
                },
                icon: visibleIcon,
            ),
          ),
        )
      ],
    );
  }
}
