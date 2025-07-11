import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ThemeS'),
        actions: [
          IconButton(
            onPressed: () {
              // Call the toggle method from our provider.
              themeProvider.toggleTheme();
            },
            icon: Icon(
              // The icon changes based on the theme state.
              themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              themeProvider.isDarkMode
                  ? Icons.nightlight_round
                  : Icons.wb_sunny_rounded,
              size: 100,
              // Change icon color based on theme for better visibility
              color: themeProvider.isDarkMode ? Colors.yellow : Colors.orange,
            ),
            const SizedBox(height: 20),
            const Text(
              'Now it works!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}