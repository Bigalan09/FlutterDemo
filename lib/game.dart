import 'package:wordquare_mobile/domain.dart';

class WordSquare {
  late Context _context;

  Context get context => _context;

  Future<bool> init() async {
    List<Player> players = <Player>[
      Player(Board(List.generate(25, (index) { return Letter(index: index); }, growable: false)), "Player 1")
    ];
    List<List<Letter>> keys = <List<Letter>>[];
    int currentPlayerIndex = 0;
    String currentLetter = "";

    _context = Context(players, keys, currentLetter, currentPlayerIndex);

    return true;
  }
}
