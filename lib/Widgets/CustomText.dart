import 'package:flutter/material.dart';
class Customtext extends StatelessWidget {
  String? title;
  Customtext(this.title);
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "$title",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    ;
  }
}
