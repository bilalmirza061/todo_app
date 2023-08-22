import 'package:flutter/material.dart';

class CustomEButton extends StatelessWidget {
  const CustomEButton(
      {Key? key, required this.onTap, required this.text, required this.icon})
      : super(key: key);
  final Function() onTap;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon),
        label: Text(text),
      ),
    );
  }
}
