import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  //run app with provider to provide card data
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => CardProvider()),
  ], child: const MyApp()));
}
//create card data model
class CardData {
  //store icon to show
  final IconData icon;
  //store flip status
  bool isFlipped = false;

  CardData({required this.icon, this.isFlipped = false});
}
//create card provider to manage card grid state
class CardProvider extends ChangeNotifier {
  
  //4x4 card grid
  final List<CardData> _cards = List.generate(16, (index) => CardData(icon: Icons.star, isFlipped: false));

  //get card data
  List<CardData> get cards => _cards;

  //flip card at index
  void flipCard(int index) {
    //flip card
    _cards[index].isFlipped = !_cards[index].isFlipped;
    //update ui
    notifyListeners();
  }
  
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
            child: CardGrid(),
          ),
        ),
      ),
    );
  }
}

//create card grid widget
class CardGrid  extends StatelessWidget {
  const CardGrid({super.key});

  @override
  Widget build(BuildContext context) {
    //get card provider
    final provider = Provider.of<CardProvider>(context);
    //create card grid
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: provider.cards.length,
      itemBuilder: (context, index) {
        return GameCard(cardData: provider.cards[index], onFlip: () {
          //flip card on tap
          provider.flipCard(index);
        });
      },
    );
  }
}

//create card widget
class GameCard extends StatelessWidget {
  final CardData cardData;
  //callback to flip card
  final VoidCallback onFlip;

  const GameCard({super.key, required this.cardData, required this.onFlip});

  //animation
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        //flip on tap
        onTap: onFlip,
        //add flip animation with AnimatedBuilder
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(cardData.isFlipped ? pi : 0),

            //flip in place
            transformAlignment: Alignment.center,
          child: cardData.isFlipped ? _buildCardFront() : _buildCardBack(),
        )
    );
  }

  //build card front
  Widget _buildCardFront() {
    return Container(
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
      child: Center(
        child: Icon(
          cardData.icon,
          size: 50,
          color: Colors.yellow,
        ),
      ),
    );
  }
  //build card back
  Widget _buildCardBack() {
    return Container(
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
    );
  }

}

