import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'views/intro_screen.dart';

void main() {
  runApp(const PartyGlowApp());
}

// Task 2: StatelessWidget Hello World (converted to full app)
class PartyGlowApp extends StatelessWidget {
  const PartyGlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Party Glow',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        fontFamily: GoogleFonts.poppins().fontFamily,
        scaffoldBackgroundColor: const Color(0xFFF5F5DC),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF5F5DC),
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xFF8B4513)),
        ),
      ),
      home: const IntroScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
