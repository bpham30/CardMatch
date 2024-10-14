import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card Matching Game',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Card Matching Game', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,)),
          backgroundColor: Colors.pink,
        ),
        body: const Padding( padding:  EdgeInsets.all(16),
          child: Text('Hello World'),
        ),
      ),
    );
  }
}

