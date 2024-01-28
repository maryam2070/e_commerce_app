import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final VoidCallback ontap;
  final String text;

  const MainButton({super.key, required this.ontap, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor),
            onPressed: ontap,
            child: Text(text, style: TextStyle(color: Colors.white))));
  }
}
