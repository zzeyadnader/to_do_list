import 'package:flutter/material.dart';
class CustomNavbar extends StatelessWidget {
  final VoidCallback onCalendarTap;
  final VoidCallback onNotesTap;

  const CustomNavbar({
    super.key,
    required this.onCalendarTap,
    required this.onNotesTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      child: SizedBox(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.calendar_month),
                iconSize: 28,
                onPressed: onCalendarTap,
              ),

              const SizedBox(width: 40),
               IconButton(
                icon: const Icon(Icons.note_alt),
                iconSize: 28,
                onPressed: onNotesTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}