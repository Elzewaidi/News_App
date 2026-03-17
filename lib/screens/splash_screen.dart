import 'package:flutter/material.dart';
import 'bookmark_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  void _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    // Replace with your preferred routing method (go_router, auto_route, etc.)
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const BookmarkScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3FA), // Light blue background
      body: Center(
        child: Text(
          'News',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2E5BCC), // Distinctive blue text
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}
