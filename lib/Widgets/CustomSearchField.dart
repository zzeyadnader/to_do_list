import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/TaskProvider.dart';

class CustomSearchField extends StatefulWidget {
  const CustomSearchField({super.key});

  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.read<TaskProvider>();

    return Container(
      width: MediaQuery.of(context).size.width * 0.93,
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
        controller: _searchController,
        decoration: InputDecoration(
          hintText: "Search",
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide.none,
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
              taskProvider.updateSearchQuery('');
            },
          ),
        ),
        onChanged: (value) {
          taskProvider.updateSearchQuery(value);
        },
      ),
    );
  }
}