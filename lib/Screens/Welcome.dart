import 'package:flutter/material.dart';
import 'package:to_do_list/Screens/HomePage.dart';

import '../Widgets/Button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

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

          const SizedBox(height: 30),
          const Text(
            "Welcome to Day Craft",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "A workspace to over 10 Million influencers around the global of the world.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: CustomButton(title: "Let's Start",onPressed: () {Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Homepage(),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
