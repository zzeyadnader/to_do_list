import 'package:flutter/material.dart';

import 'CustomIconbutton.dart';

class Customappbar extends StatelessWidget {
  const Customappbar({super.key});

  @override
  Widget build(BuildContext context) {
    return     Container(
      padding: EdgeInsets.only(top: 60 , left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Day Craft" , style: TextStyle(fontSize: 24 , fontWeight: FontWeight.bold , color: Color(0xff181D3F)),),
          Container(
            padding: EdgeInsets.only(right: 20),child:
          Row(children: [
            SizedBox(width: 10,),
            CustomIconButton(icon: Icons.more_vert,onPressed: () {
            },)

          ],)
            ,)
        ],
      ),
    );
  }
}
