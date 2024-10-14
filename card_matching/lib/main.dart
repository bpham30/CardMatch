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
          child:GameCard( icon: Icons.star),
        ),
      ),
    );
  }
}

//create card widget
class GameCard extends StatefulWidget {
  //store icon to show
  final IconData icon;
  const GameCard({super.key, required this.icon});


  @override
  _GameCardState createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  //track flip status
  bool isFlipped = false;

  //function to flip card state
  void _flip(){
    setState(() {
      isFlipped = !isFlipped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flip,
      child: Container(
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
        //show flipped image
        child: isFlipped
            ? const Icon(
                Icons.star, 
                size: 50,
                color: Colors.yellow,
              ) 
            : const Icon(
                Icons.question_mark, 
                size: 50,
                color: Colors.pink,
              ), 
      ),
      //add button to flip the card
      
    )
    );
  }
    
  }

 