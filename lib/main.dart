import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './providers/theme_provider.dart';
import './screens/home_screen.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  //  Get the SharedPreferences instance.
  final prefs = await SharedPreferences.getInstance();

  //  Get the saved theme. If it's null (first run), default to false (light mode).
  final bool isDark = prefs.getBool(ThemeProvider.THEME_STATUS_KEY) ?? false;


  runApp(MyApp(isDark: isDark));
}

class MyApp extends StatelessWidget {
  // We accept the initial theme state from main().
  final bool isDark;
  const MyApp({Key? key, required this.isDark}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          // We create the ThemeProvider and pass the saved theme state to it.
          create: (_) => ThemeProvider(isDark: isDark),
        ),

        // You can add more providers here in the future:

      ],
      // We use a Builder here to get a 'context' that has access to the providers.
      child: Builder(
        builder: (BuildContext context) {
          // We get the themeProvider instance to set the initial theme of MaterialApp.
          final themeProvider = Provider.of<ThemeProvider>(context);

          return MaterialApp(
            title: 'Theme App',
            debugShowCheckedModeBanner: false,

            // The themeMode is now controlled by the provider.
            themeMode: themeProvider.themeMode,

            // Light theme data
            theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.blue,
              useMaterial3: true,
            ),

            // Dark theme data
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.indigo,
              useMaterial3: true,
            ),

            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}