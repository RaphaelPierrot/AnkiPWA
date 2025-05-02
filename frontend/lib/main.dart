import 'package:flutter/material.dart';
import 'pages/home_page.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  // initialise Flutter (obligatoire avant tout code async)
  WidgetsFlutterBinding.ensureInitialized();

  // Choix automatique DEV / PROD
  final env = const String.fromEnvironment('APP_ENV', defaultValue: 'dev');
  await dotenv.load(fileName: '.env.$env');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anki PWA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1E1E1E),
        cardColor: const Color(0xFF2A2A2A),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF2A2A2A),
        ),
      ),
      home: const HomePage(),
    );
  }
}
