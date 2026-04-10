import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = true;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FS Generador',
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: _buildTheme(false),
      darkTheme: _buildTheme(true),
      home: SplashScreen(
        onToggleTheme: toggleTheme,
      ),
    );
  }

  ThemeData _buildTheme(bool isDark) {
    final surface = isDark ? const Color(0xFF080e1c) : const Color(0xFFF8FAFC);
    final onSurface = isDark ? const Color(0xFFe0e5f9) : const Color(0xFF0F172A);
    final primary = isDark ? const Color(0xFF85adff) : const Color(0xFF2563EB); 
    final secondary = isDark ? const Color(0xFF69f6b8) : const Color(0xFF059669); 

    final baseTextTheme = isDark ? ThemeData.dark().textTheme : ThemeData.light().textTheme;

    return ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor: surface,
      colorScheme: ColorScheme(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: primary,
        onPrimary: const Color(0xFF002c66),
        secondary: secondary,
        onSecondary: const Color(0xFF005a3c),
        error: const Color(0xFFff716c),
        onError: const Color(0xFF490006),
        surface: surface,
        onSurface: onSurface,
      ),
      textTheme: GoogleFonts.manropeTextTheme(baseTextTheme).apply(
        bodyColor: onSurface,
        displayColor: onSurface,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: surface,
        elevation: 0,
        iconTheme: IconThemeData(color: primary),
      ),
      useMaterial3: true,
    );
  }
}
