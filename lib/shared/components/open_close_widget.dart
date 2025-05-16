
import 'package:flutter/material.dart';

class IsOpenOrClosedWidegt extends StatelessWidget {
  const IsOpenOrClosedWidegt({super.key, required this.isOpen});

  final bool isOpen;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isOpen ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        isOpen ? 'Open' : 'Closed',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }
}
