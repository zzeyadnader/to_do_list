import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/View/HomePage.dart';
import 'package:to_do_list/View/RegisterPage.dart';
import 'package:to_do_list/ViewModels/authProvider.dart';
import 'package:to_do_list/Widgets/CustomAppbar.dart';
import 'package:to_do_list/Widgets/CustomTextField.dart';

import '../Widgets/CustomButton.dart';
class  Loginpage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passcontroller = TextEditingController();



  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
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
                Customtextfield(controller: emailController, hint: "Email",isPassword : false),
                SizedBox(height: 15,),
                Customtextfield(controller: passcontroller, hint: "Password" , isPassword : true),
                Padding(
                  padding: const EdgeInsets.only(top: 30, right: 70 ,left: 70),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: CustomButton(title: "Login",  onPressed: () async {
                      final error = await authProvider.login(
                        emailController.text.trim(),
                        passcontroller.text.trim(),
                      );
                      if (error != null) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(error)));
                      } else {
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Homepage(),));
                      }
                    },
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 30 ) ,
                  child:InkWell( onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Registerpage()));
                  }, child: Text("Don't have an account? Register Now" , style: TextStyle(color: Colors.blue),),),
                ),

              ],
            ),),
          ],
        ),
      ),
    );
  }
}