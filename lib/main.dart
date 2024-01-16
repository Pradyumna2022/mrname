import 'package:flutter/material.dart';
import 'package:mrname/mrName/views/splash_screen.dart';
import 'package:mrname/rar.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
   MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  final ThemeData lightTheme = ThemeData(
    // Define your light theme properties here
    brightness: Brightness.light,
    // other properties...
  );
  final ThemeData darkTheme = ThemeData(
    // Define your dark theme properties here
    brightness: Brightness.dark,
    // other properties...
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.red,
      home: SplashScreen(),
      theme: ThemeData.light(
        useMaterial3: true
      ), // Initial theme, it will be overridden
      darkTheme: ThemeData.dark(
          useMaterial3: true
      ), // Initial dark theme, it will be overridden
      themeMode: ThemeMode.system, // Use system theme
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            // Listen to system brightness
            platformBrightness: MediaQuery.of(context).platformBrightness,
          ),
          child: Theme(
            data: MediaQuery.of(context).platformBrightness == Brightness.dark
                ? darkTheme
                : lightTheme,
            child: child!,
          ),
        );
      },
    );
  }
}
