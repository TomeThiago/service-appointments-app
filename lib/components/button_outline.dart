import 'package:flutter/material.dart';

class ButtonOutline extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final double? height;

  const ButtonOutline({
    super.key,
    required this.title,
    required this.onPressed,
    this.height = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: Size(100.0, height!),
        side: const BorderSide(
          width: 2.0,
          color: Colors.deepOrangeAccent,
        ),
      ),
      child: Text(title),
    );
  }
}
