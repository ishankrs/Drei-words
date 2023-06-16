import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(const WordApp());
}

class WordApp extends StatelessWidget {
  const WordApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0, 0.49, 1],
              colors: [
                const Color.fromRGBO(2, 0, 36, 1),
                const Color.fromRGBO(221, 0, 0, 1),
                const Color.fromRGBO(255, 204, 0, 1),
              ],
              transform: GradientRotation(120 * pi / 180),
            ),
          ),
          child: const Center(
            child: RandomWordCard(),
          ),
        ),
      ),
    );
  }
}

class RandomWordCard extends StatefulWidget {
  const RandomWordCard({Key? key}) : super(key: key);

  @override
  _RandomWordCardState createState() => _RandomWordCardState();
}

class _RandomWordCardState extends State<RandomWordCard> {
  List<String> randomWords = ['Tap the button to fetch random words!'];

  Future<void> fetchRandomWords() async {
    final wordList = await rootBundle.loadString('assets/words2.txt');
    final words = wordList.split('\n').where((word) => word.isNotEmpty).toList();

    final random = Random();

    setState(() {
      randomWords = List.generate(3, (index) {
        final randomIndex = random.nextInt(words.length);
        return words[randomIndex];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [            const SizedBox(height: 100.0),

            const Text(
              'Random Words For today',
              style: TextStyle(fontSize: 24.0, color: Colors.white),
            ),
            const SizedBox(height: 120.0),
            Column(
              children: randomWords
                  .map(
                    (word) => Column(
                      children: [
                        Text(
                          word,
                          style: const TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 120.0),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: fetchRandomWords,
          child: const Text('Fetch Random Words'),
          style: ElevatedButton.styleFrom(
            primary: const Color.fromRGBO(255, 204, 0, 1),
            fixedSize: const Size(380.0, 83.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
              side: const BorderSide(
                color: Color.fromRGBO(0, 0, 0, 0.2),
                width: 1.0,
              ),
            ),
            shadowColor: Colors.black.withOpacity(0.25),
            elevation: 4.0,
            textStyle: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 40.0),
      ],
    );
  }
}
