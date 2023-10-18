import 'package:flutter/material.dart';
import 'package:my_app/Styles/Colors.dart';

class CompleteMessage extends StatelessWidget {
  final String message;

  CompleteMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Blue,
      padding: EdgeInsets.all(16.0),
      child: Text(
        message,
        style: TextStyle(
          color: Persian_Orange,
          fontSize: 18.0,
        ),
      ),
    );
  }
}