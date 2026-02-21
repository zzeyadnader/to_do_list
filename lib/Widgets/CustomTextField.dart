import 'package:flutter/material.dart';

class Customtextfield extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final bool isPassword;

  const Customtextfield({
    super.key,
    required this.controller,
    required this.hint,
    this.isPassword = false,
  });

  @override
  State<Customtextfield> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<Customtextfield> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
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
        controller: widget.controller,
        obscureText: widget.isPassword ? _obscureText : false,
        decoration: InputDecoration(
          hintText: widget.hint,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide.none,
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
            icon: Icon(
              _obscureText
                  ? Icons.visibility_off
                  : Icons.visibility,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          )
              : null,
        ),
      ),
    );
  }
}