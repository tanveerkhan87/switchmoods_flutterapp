import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dark_and_light_moods.dart';  // Import your custom file (if needed for screen or functionality)

void main() {
  // This is the entry point of the app. We run the MyApp widget.
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Variable to store the current theme mode (light or dark)
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadTheme();  // Load the saved theme preference when the app starts
  }

  // Function to load the saved theme mode from SharedPreferences
  void _loadTheme() async {
    // Access SharedPreferences to retrieve the saved theme mode
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      // Retrieve the 'isDarkMode' value, default to false (light mode) if not found
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

// Function to toggle between light and dark modes
  void _toggleTheme(bool isDark) async {
    // Get an instance of SharedPreferences (this is like a small storage for the app)
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Update the state of the app to reflect the selected theme (dark or light)
    setState(() {
      isDarkMode = isDark;  // 'isDark' is the theme the user selected (true for dark, false for light)
    });

    // Save the selected theme (dark or light) in SharedPreferences
    // This way, the app remembers the user's choice even after closing and reopening
    await prefs.setBool('isDarkMode', isDark);
  }


  @override
  Widget build(BuildContext context) {
    // The MaterialApp widget is the root of your Flutter app.
    return MaterialApp(
      title: 'Flutter Demo',  // Set the app title
      // Set the theme mode dynamically based on the isDarkMode value
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      // Define the light theme
      theme: ThemeData.light(),
      // Define the dark theme
      darkTheme: ThemeData.dark(),
      // Pass the _toggleTheme function to MoodsScreen widget to toggle the theme
      home: MoodsScreen(toggleTheme: _toggleTheme),
    );
  }
}
