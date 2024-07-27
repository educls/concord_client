import 'package:flutter/material.dart';

class BackgroundPage extends StatelessWidget {
  const BackgroundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 154, 160, 187),
      appBar: AppBar(
        title: const Text('Background Page'),
      ),
    );
  }
}

