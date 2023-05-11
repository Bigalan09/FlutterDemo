import 'package:flutter/material.dart';
import 'package:wordquare_mobile/domain.dart';
import 'package:wordquare_mobile/game.dart';
import 'package:wordquare_mobile/widgets/alphabet/alphabet.dart';
import 'package:wordquare_mobile/widgets/grid/grid.dart';

class Board extends StatefulWidget {
  final WordSquare _game;

  const Board(this._game, {super.key});

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  int? selectedCellIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Grid(
          gridState: widget._game.context
              .players[widget._game.context.currentPlayerIndex].board,
          onCellClicked: onCellClicked,
        ),
        Alphabet(
          keyboard: widget._game.context.keyboard,
          onLetterPressed: onLetterPressed,
          onAccepted: onAccepted,
          onCancelled: onCancelled,
        )
      ],
    );
  }

  onCellClicked(int index) {
    setState(() {
      var cell = widget._game.context
          .players[widget._game.context.currentPlayerIndex].board.tiles
          .elementAt(index);
      if (cell.value == "") {
        widget._game.context.players[widget._game.context.currentPlayerIndex]
            .board.tiles
            .where((element) => element.color == GameColor.selected)
            .forEach((element) {
          element.color = GameColor.empty;
          widget._game.context.keyboard.selectedLetter = null;
        });

        if (selectedCellIndex == index) {
          selectedCellIndex = null;
          widget._game.context.keyboard.state = KeyboardState.disabled;
          widget._game.context.keyboard.selectedLetter = null;
        } else {
          selectedCellIndex = index;
          widget._game.context.keyboard.state = KeyboardState.lettersOnly;

          if (cell.value == "") {
            selectedCellIndex = index;
            if (selectedCellIndex != null && selectedCellIndex! > -1) {
              cell.color = GameColor.selected;
            }
          } else {
            selectedCellIndex = null;
          }
        }
      }
    });
  }

  onAccepted() {
    var cell = widget._game.context
        .players[widget._game.context.currentPlayerIndex].board.tiles
        .elementAt(selectedCellIndex!);
    setState(() {
      if (cell.value == "") {
        selectedCellIndex = null;
        cell.color = GameColor.confirmed;
        cell.value = widget._game.context.keyboard.selectedLetter!;
        widget._game.context.keyboard.selectedLetter = null;
        widget._game.context.keyboard.state = KeyboardState.disabled;
      }
    });
  }

  onCancelled() {
    setState(() {
      widget._game.context.keyboard.selectedLetter = null;
      widget._game.context.keyboard.state = KeyboardState.lettersOnly;
    });
  }

  onLetterPressed(String letter) {
    setState(() {
      if (selectedCellIndex! > -1) {
        widget._game.context.keyboard.state = KeyboardState.actionsOnly;
        widget._game.context.keyboard.selectedLetter = letter;
      } else {
        widget._game.context.keyboard.state = KeyboardState.disabled;
      }
    });
  }
}
