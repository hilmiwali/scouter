import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/lookup_screen.dart';
import 'screens/results_screen.dart';
import 'screens/history_screen.dart';

class ScouterApp extends StatelessWidget {
  const ScouterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scouter - OSINT Toolkit',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/lookup': (context) => const LookupScreen(),
        '/results': (context) => const ResultsScreen(),
        '/history': (context) => const HistoryScreen(),
      },
    );
  }
}
