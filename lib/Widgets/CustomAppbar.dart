import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/View/LoginPage.dart';
import '../ViewModels/TaskProvider.dart';
import '../ViewModels/authProvider.dart';
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
          PopupMenuButton(onSelected: (value) async {
            if(value=="logout"){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Loginpage(),));
            }else if (value == "refresh") {
              final token = Provider.of<AuthProvider>(context, listen: false).token;
              if (token != null) {
                await Provider.of<TaskProvider>(context, listen: false).fetchTodos(token);
              }
            }
          },
            itemBuilder: (context) => [
            PopupMenuItem(child: Row(children: [Text("Logout") , SizedBox(width: 5),Icon(Icons.logout , size: 18,)],) ,value: "logout"),
              PopupMenuItem(child: Row(children: [Text("Refresh") , SizedBox(width: 5),Icon(Icons.refresh , size: 18,)],) ,value: "refresh"),
          ],
            child: CustomIconButton(icon: Icons.more_vert),
          ),
        ],
      ),
    );
  }
}

