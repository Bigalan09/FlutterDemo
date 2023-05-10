import 'package:wordquare_mobile/domain.dart';

class WordSquare {
  late Context _context;

  Context get context => _context;

  void init() {
    List<Player> players = <Player>[
      Player(Board(List.filled(25, Letter(), growable: false)), "Player 1")
    ];
    List<List<Letter>> keys = <List<Letter>>[];
    int currentPlayerIndex = 0;
    String currentLetter = "";

    _context = Context(players, keys, currentLetter, currentPlayerIndex);
  }
}
