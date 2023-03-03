import 'package:flutter/material.dart';
import 'package:live_stream_app/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  const CustomTextField(
      {super.key, required this.controller, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: text,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: buttonColor,
            width: 2,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
      ),
    );
  }
}
