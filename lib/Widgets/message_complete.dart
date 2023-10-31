import 'package:flutter/material.dart';
import 'package:my_app/Styles/Colors.dart';

class CompleteMessage extends StatelessWidget {
  final String message;

  CompleteMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Blue,
      ),
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