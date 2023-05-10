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
            onCellClicked: onCellClicked),
        const SizedBox(height: 20),
        Alphabet(onLetterPressed: onLetterPressed)
      ],
    );
  }

  onCellClicked(int index) {
    setState(() {
      if (selectedCellIndex == index) {
        selectedCellIndex = null;
      } else {
        var cell = widget._game.context
            .players[widget._game.context.currentPlayerIndex].board.tiles
            .elementAt(index);
            
        if (cell.value == "") {
          setState(() {
            selectedCellIndex = index;
            if (selectedCellIndex != null && selectedCellIndex! > -1) {
              cell.index = index;
              cell.color = GameColor.selected;
            }
          });
        }
      }
    });
  }

  onLetterPressed(String letter) {
    setState(() {
      if (selectedCellIndex != null && selectedCellIndex! > -1) {
        var tile = widget
            ._game
            .context
            .players[widget._game.context.currentPlayerIndex]
            .board
            .tiles[selectedCellIndex!];
        tile.value = letter;
        tile.color = GameColor.confirmed;
      }
    });
  }
}
