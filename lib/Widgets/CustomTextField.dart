import 'package:flutter/material.dart';
class Customtextfield extends StatelessWidget {
   TextEditingController controller;
   String hint;
   Customtextfield({required this.controller,required this.hint,super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 15),
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: [
            Color(0xff3786EB),
            Color(0xff8ED0FA),
          ],
        ),
      ),
      child: TextField(
        controller: controller ,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
