import 'package:flutter/material.dart';
import 'package:wp_status_saver/Screens/homepage.dart';
import 'package:wp_status_saver/constants/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void navigate() async {
    await Future.delayed(const Duration(milliseconds: 200), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(child: Image.asset(logo)),
      ),
    );
  }
}
