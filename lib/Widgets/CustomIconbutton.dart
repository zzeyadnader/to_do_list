import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const CustomIconButton({
    super.key,
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xffF6F6F6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: onPressed,
        customBorder:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)) ,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            color: Colors.black,
            size: 20,
          ),
        ),
      ),
    );
  }
}