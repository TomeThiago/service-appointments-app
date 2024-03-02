import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final double? height;
  final double? fontSize;

  const Button({super.key, required this.title, required this.onPressed, this.height = 50.0, this.fontSize = 18.0});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepOrangeAccent,
        minimumSize: Size(100.0, height!),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
        ),
      ),
    );
  }
}