import 'package:flutter/material.dart';
import 'package:wordquare_mobile/domain.dart';

class Alphabet extends StatefulWidget {
  final Function(String) onLetterPressed;
  final Function onCancelled;
  final Function onAccepted;
  final Keyboard keyboard;

  const Alphabet({
    required this.onLetterPressed,
    required this.onCancelled,
    required this.onAccepted,
    required this.keyboard,
    super.key,
  });

  @override
  State<Alphabet> createState() => _AlphabetState();
}

class _AlphabetState extends State<Alphabet> {
  @override
  Widget build(BuildContext context) {
    List<String> row1 = ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'];
    List<String> row2 = ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'];
    List<String> row3 = ['CANCEL', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', 'ACCEPT'];

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
              bool keyEnabled = true;

              if ((letter != "ACCEPT" &&
                      widget.keyboard.state == KeyboardState.actionsOnly) &&
                  (letter != "CANCEL" &&
                      widget.keyboard.state == KeyboardState.actionsOnly)) {
                keyEnabled = false;
              }

              if ((letter == "ACCEPT" &&
                      widget.keyboard.state == KeyboardState.lettersOnly) ||
                  (letter == "CANCEL" &&
                      widget.keyboard.state == KeyboardState.lettersOnly)) {
                keyEnabled = false;
              }

              if (widget.keyboard.state == KeyboardState.disabled) {
                keyEnabled = false;
              }

              return GestureDetector(
                onTap: keyEnabled ? () {
                  if (letter == "ACCEPT") {
                    widget.onAccepted();
                  } else if (letter == "CANCEL") {
                    widget.onCancelled();
                  } else {
                    widget.onLetterPressed(letter);
                  }
                } : null,
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(
                      vertical: 3.0, horizontal: 2.0),
                  padding: const EdgeInsets.symmetric(
                      vertical: 17.0, horizontal: 13.0),
                  decoration: BoxDecoration(
                      color: (keyEnabled) ? Colors.black87 : (widget.keyboard.selectedLetter == letter) ? Colors.amber[300]! : Colors.black45,
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
