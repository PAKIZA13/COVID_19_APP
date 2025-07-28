import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'world_states.dart'; // Don't forget to import the screen you're navigating to

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();

  @override
  void initState() {
    super.initState();
    // Navigate to the next screen after 3 seconds
    Timer(
      const Duration(seconds: 3),
          () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WorldStates()), // Adjust your WorldStates screen
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: controller,
            child: Container(
              width: 200,
              height: 200,
              child: Center(child: Image.asset("assets/virus.png")),
            ),
            builder: (BuildContext context, Widget? child) {
              return Transform.rotate(angle: controller.value * 2.0 * 3.14, child: child);
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
          Align(
            alignment: Alignment.center,
            child: Text(
              "Covid 19\nTracker App",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
