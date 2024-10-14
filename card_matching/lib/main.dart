import 'dart:math';

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
          title: const Text('Card Matching Game',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          backgroundColor: Colors.pink,
        ),
        body: const Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: GameCard(icon: Icons.star),
          ),
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
  void _flip() {
    setState(() {
      isFlipped = !isFlipped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        //flip on tap
        onTap: _flip,
        //add flip animation with AnimatedBuilder
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            //create rotate animation
           final rotateAnim = Tween(begin: 0.0, end: 1.0).animate(animation);
            
            return AnimatedBuilder(
              animation: rotateAnim,
              child: child, 
              builder: (context, child) {
              
              //rotate card based on flip
              if (isFlipped) {
                return Transform(
                  transform: Matrix4.rotationY(pi * rotateAnim.value),
                  alignment: Alignment.center,
                  child: child,
                );
              } else {
                return Transform(
                  transform: Matrix4.rotationY(pi * rotateAnim.value + pi),
                  alignment: Alignment.center,
                  child: child,
                );

              }
              },
            );
            //show card based on flip
          },
          child: isFlipped
          //
      ? Container(
          //key to differentiate between widgets
          key: const ValueKey(true),
          height: 100,
          width: 75,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.black.withOpacity(.05),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.yellow.withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: const Center(
            child: Icon(
              Icons.star,
              size: 50,
              color: Colors.yellow,
            ),
          ),
        )
      : Container(
          //key to differentiate between widgets
          key: const ValueKey(false),
          height: 100,
          width: 75,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.black.withOpacity(.05),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.pink.withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: const Center(
            child: Icon(
              Icons.question_mark,
              size: 50,
              color: Colors.pink,
            ),
          ),
        ),
        ));
  }
}
