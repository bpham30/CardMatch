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
          child:GameCard( isFlipped: false, icon: 'https://pngimg.com/uploads/pumpkin/pumpkin_PNG86730.png',),
        ),
      ),
    );
  }
}

class GameCard extends StatefulWidget {
  
  final bool isFlipped;
  final String icon;
  const GameCard({super.key, required this.isFlipped, required this.icon});


  @override
  _GameCardState createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black.withOpacity(.05), width: 1),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Center(
        child: widget.isFlipped
            ? const Icon(
                Icons.star, // Placeholder icon for the card back
                size: 50,
                color: Colors.pink,
              ) // Display the image when flipped
            : const Icon(
                Icons.question_mark, // Placeholder icon for the card back
                size: 50,
                color: Colors.pink,
              ), 
      ),
      //add button to flip the card
      
    );
  }
    
  }

 