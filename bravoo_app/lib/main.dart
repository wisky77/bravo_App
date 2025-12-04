import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/enter_email.dart';
import 'screens/home_screen.dart';
import 'core/supabase_client.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase (using provided URL and anon key)
  await SupabaseManager.init(
    supabaseUrl: 'https://ebebsuwuenushsnhajru.supabase.co',
    supabaseAnonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImViZWJzdXd1ZW51c2hzbmhhanJ1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQ4NTc5MTMsImV4cCI6MjA4MDQzMzkxM30.M13IvDJq4q1Nx5rEdut2-rlD9xnmQTbWKimJYzxyAQg',
  );

  // Set status bar to transparent with light icons
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const BravooApp());
}

class BravooApp extends StatelessWidget {
  const BravooApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bravoo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/enter-email': (context) => const EnterEmailScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
