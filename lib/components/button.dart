import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final double? height;
  final double? fontSize;
  final bool? isDisabled;

  const Button({
    super.key,
    required this.title,
    required this.onPressed,
    this.height = 50.0,
    this.fontSize = 18.0,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isDisabled != null && isDisabled != false ? Colors.white10 : Colors.deepOrangeAccent,
        minimumSize: Size(100.0, height!),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
