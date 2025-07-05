import 'package:flutter/material.dart';

// The MoodsScreen widget allows the user to switch between light and dark modes
class MoodsScreen extends StatelessWidget {
  final Function(bool) toggleTheme;  // The function to toggle the theme

  const MoodsScreen({super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Moods Screen"),  // App bar title
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Light mode icon button
            IconButton(
              icon: const Icon(Icons.wb_sunny),
              onPressed: () => toggleTheme(false),  // Switch to light mode
              iconSize: 50,
            ),
            const SizedBox(width: 50),  // Add space between icons
            // Dark mode icon button
            IconButton(
              icon: const Icon(Icons.nightlight_round),
              onPressed: () => toggleTheme(true),  // Switch to dark mode
              iconSize: 50,
            ),
          ],
        ),
      ),
    );
  }
}
