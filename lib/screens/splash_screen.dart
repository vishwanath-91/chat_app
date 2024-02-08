import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        children: [
          Center(
            child: CircularProgressIndicator(),
          ),
          SizedBox(height: 10),
          // Add some spacing between the CircularProgressIndicator and Text
          Text("Loading..."),
        ],
      ),
    );
  }
}
