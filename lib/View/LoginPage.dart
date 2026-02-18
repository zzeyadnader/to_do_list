import 'package:flutter/material.dart';
import 'package:to_do_list/Widgets/CustomAppbar.dart';
import 'package:to_do_list/Widgets/CustomTextField.dart';

import '../Widgets/CustomButton.dart';
class  Loginpage extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: Image.asset(
                  "Images/Welcome.png",
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.white,
                        Colors.white.withOpacity(0.0),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),
          const SizedBox(height: 10),
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            child: Column(
            children: [
              const Text(
                "Login",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 50,),
              Customtextfield(controller: controller, hint: "Email"),
              SizedBox(height: 15,),
              Customtextfield(controller: passcontroller, hint: "Password"),
              Padding(
                padding: const EdgeInsets.only(top: 30, right: 70 ,left: 70),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: CustomButton(title: "Login",onPressed: () {}),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 30 ) ,
                child:InkWell(child: Text("Don't have an account? Register Now" , style: TextStyle(color: Colors.blue),),),
              ),

            ],
          ),),
        ],
      ),
    );
  }
}