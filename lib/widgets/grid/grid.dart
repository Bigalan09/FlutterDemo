import 'package:flutter/material.dart';
import 'package:wordquare_mobile/domain.dart';

class Grid extends StatelessWidget {
  final Board gridState;
  final Function(int index) onCellClicked;

  const Grid({required this.gridState, super.key, required this.onCellClicked});

  Color toColor(GameColor color) {
    switch (color) {
      case GameColor.empty:
        return Colors.black54;
      case GameColor.confirmed:
        return Colors.black87;
      case GameColor.selected:
        return Colors.amber[300]!;
      default:
        return Colors.black54;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: 25,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
        itemBuilder: (BuildContext context, int index) {
          return GridTile(
            child: GestureDetector(
              onTap: () {
                onCellClicked(index);
              },
              child: Card(
                color: toColor(gridState.tiles[index].color),
                child: Center(
                  child: Text(
                    gridState.tiles[index].value,
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
