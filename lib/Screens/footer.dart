import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red.shade900,
      padding: const EdgeInsets.all(20),
      child: const Center(
        child: Text(
          '© 2025 Blood Donation App. All Rights Reserved.',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
