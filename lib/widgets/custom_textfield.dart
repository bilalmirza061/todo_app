import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({Key? key, required this.height, required this.txt, required this.controller}) : super(key: key);
  final double height;
  final String txt;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(width: 2),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: txt,
        ),
      ),
    );
  }
}
