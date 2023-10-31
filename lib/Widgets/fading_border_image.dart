import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class FadingBorderImage extends StatefulWidget {
  @override
  _FadingBorderImageState createState() => _FadingBorderImageState();
}

class _FadingBorderImageState extends State<FadingBorderImage> {
  double _borderWidth = 20.0;
  double _borderOpacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(
        begin: 20.0, // Initial border width
        end: 0.0,  // Final border width (0 for a fade-out effect)
      ),
      duration: Duration(seconds: 2), // Adjust the duration as needed
      builder: (context, value, child) {
        _borderWidth = value;
        _borderOpacity = value / 20.0; // Adjust this value for opacity

        return ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            width: 200, // Adjust the width and height as needed
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue, // Border color
                width: _borderWidth,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Opacity(
              opacity: _borderOpacity,
              child: Image(image: AssetImage('assets/background4.jpg'),)
            ),
          ),
        );
      },
    );
  }
}
