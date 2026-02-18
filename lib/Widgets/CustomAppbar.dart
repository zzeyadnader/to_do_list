import 'package:flutter/material.dart';

import 'CustomIconbutton.dart';

class Customappbar extends StatelessWidget {
  final String title;
  const Customappbar({this.title = "Day Craft", super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 60, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xff181D3F))),
          CustomIconButton(icon: Icons.more_vert, onPressed: () {}),
        ],
      ),
    );
  }
}

