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
  //store icon data
  final IconData icon;
  //store flip status
  bool isFlipped = false;
  //store match status
  bool isMatching = false;

  CardData({required this.icon, this.isFlipped = false, this.isMatching = false});
}
//create card provider to manage card grid state
class CardProvider extends ChangeNotifier {
  //icon list
  final List <IconData> icons = [
    Icons.star,
    Icons.favorite,
    Icons.home,
    Icons.cake,
    Icons.pets,
    Icons.face,
    Icons.music_note,
    Icons.sports,
  ];

  //get card data
  late List<CardData> _cards;

  CardProvider(){
    //create pairs of cards in data
    _cards = _generateCards();
    //randomize
    _cards.shuffle();
  }

  //generate card pairs
  List<CardData> _generateCards() {
    List <CardData> cards = [];
    //create pairs
    for (var icon in icons) {
      cards.add(CardData(icon: icon));
      cards.add(CardData(icon: icon));
    }
    return cards;
  }

  //get cards
  List<CardData> get cards => _cards;
  //store flipped cards
  List<int> _flippedCards = [];

  //flip card 
  void flipCard(int index) {
    //if 2 are flipped, check if they match
    if (_flippedCards.length == 2 || _cards[index].isMatching) {
      return;
    }
    //flip card
    _cards[index].isFlipped = !_cards[index].isFlipped;
    //update ui
    notifyListeners();
    //add flipped card to list
    _flippedCards.add(index);
    //if 2 cards are flipped check for match
    if (_flippedCards.length == 2) {
      Future.delayed(const Duration(seconds: 1), () {
        checkForMatch();
      });
    }
    
    
  }

  //check for match
  void checkForMatch() {
    int first = _flippedCards[0];
    int second = _flippedCards[1];
    //check for match
    if (_cards[first].icon == _cards[second].icon) {
      //match
      _cards[first].isMatching = true;
      _cards[second].isMatching = true;
    } else {
      //if no match flip back
      _cards[first].isFlipped = false;
      _cards[second].isFlipped = false;
    }

    //reset
    _flippedCards = [];
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
        onTap: !cardData.isMatching && !cardData.isFlipped ? onFlip : null,
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

