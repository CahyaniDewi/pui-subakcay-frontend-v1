// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:frontend_subak/pages/prediksi.dart';
import 'package:provider/provider.dart';
import 'package:frontend_subak/pages/dashboard.dart';
import 'package:frontend_subak/pages/getstarted_screen.dart';
import 'package:frontend_subak/pages/splash_screen.dart';
import 'package:frontend_subak/pages/register_screen.dart';
import 'package:frontend_subak/pages/login_screen.dart';
import 'package:frontend_subak/providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAwaBDTn8KgWt1q-RbPx5hXqRg2z2rVk8c",
      authDomain: "agrisubak.firebaseapp.com",
      projectId: "agrisubak",
      storageBucket: "agrisubak.firebasestorage.app",
      messagingSenderId: "686959092921",
      appId: "1:686959092921:web:1c27be8449a29e508d2768",
    ),
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'AgriSubak',
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF007E65),
          onPrimary: Colors.white,
          background: Colors.white,
          onBackground: Colors.black,
          surfaceVariant: Colors.grey.shade200,
          primaryContainer: Colors.green.shade100,
          outline: Colors.grey.shade300,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFF50E3C2),
          onPrimary: Colors.black,
          background: const Color(0xFF121212),
          onBackground: Colors.white,
          surfaceVariant: Colors.grey.shade800,
          primaryContainer: Colors.teal.shade700,
          outline: Colors.grey.shade700,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/get-started': (context) => const GetStartedPage(),
        '/register': (context) => const RegisterScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/prediksi': (context) => PredictScreen(),
      },
    );
  }
}
