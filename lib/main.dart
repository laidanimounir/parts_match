import 'package:flutter/material.dart';
import 'package:parts_match/screens/splash_screen.dart';



void main() {
  runApp(const PartsMatchApp());
}

class PartsMatchApp extends StatelessWidget {
  const PartsMatchApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PartsMatch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1976D2),
        ),
        useMaterial3: true,
      ),
      
      home: SplashScreen(), 
    );
  }
}
