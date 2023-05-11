import 'package:flutter/material.dart';

class Alphabet extends StatefulWidget {
  final Function(String) onLetterPressed;
  const Alphabet({required this.onLetterPressed, super.key});

  @override
  State<Alphabet> createState() => _AlphabetState();
}

class _AlphabetState extends State<Alphabet> {
  bool keyboardEnabled = true;

  @override
  Widget build(BuildContext context) {
    List<String> row1 = ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'];
    List<String> row2 = ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'];
    List<String> row3 = ['CANCEL','Z', 'X', 'C', 'V', 'B', 'N', 'M', 'ACCEPT'];

    return Column(
      children: [
        for (var row in [row1, row2, row3])
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: row.map((letter) {
              Widget tile = Text(letter,
                  style: const TextStyle(fontSize: 14, color: Colors.white));
              if (letter == "CANCEL") {
                tile = const Icon(
                  Icons.cancel_outlined,
                  color: Colors.white,
                  size: 14.0,
                );
              } else if (letter == "ACCEPT") {
                tile = const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 14.0,
                );
              }

              return GestureDetector(
                onTap: keyboardEnabled
                    ? () {
                        setState(() {
                          if (letter == "ACCEPT" || letter == "CANCEL") {
                            keyboardEnabled = !keyboardEnabled;
                          } else {
                            widget.onLetterPressed(letter);
                          }
                        });
                      }
                    : null,
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(
                      vertical: 3.0, horizontal: 2.0),
                  padding: const EdgeInsets.symmetric(
                      vertical: 17.0, horizontal: 13.0),
                  decoration: BoxDecoration(
                      color: keyboardEnabled ? Colors.black87 : Colors.black12,
                      borderRadius: BorderRadius.circular(6)),
                  child: tile,
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}
