import 'package:flutter/material.dart';
import 'package:live_stream_app/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback function;
  final String text;
  const CustomButton({super.key, required this.function, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function,
      child: Text(text),
      style: ElevatedButton.styleFrom(
          primary: buttonColor, minimumSize: const Size(double.infinity, 40)),
    );
  }
}
