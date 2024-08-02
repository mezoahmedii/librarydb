import 'package:flutter/material.dart';

class CustomBackground extends StatelessWidget {
  final Widget? child;

  const CustomBackground({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [Colors.orangeAccent, Colors.deepOrange], begin: Alignment.topRight, end: Alignment.bottomCenter)
      ),
      child: child,
    );
  }
}
