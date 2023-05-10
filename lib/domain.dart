enum GameColor { empty, selected, confirmed }

class Letter {
  int index;
  String value;
  bool isKey;
  GameColor color;

  static const empty = '';

  Letter(
      {this.index = 0,
      this.value = Letter.empty,
      this.color = GameColor.empty,
      this.isKey = false});

  String get semanticsLabel {
    if (isKey) {
      return value.length > 1
          ? value == 'ACCEPT'
              ? 'Accept.'
              : 'Cancel.'
          : '${value.toUpperCase()}.';
    }
    return value == Letter.empty ? '' : '${value.toUpperCase()}.';
  }

  set semanticsLabel(String value) {}

  Letter.fromJson(Map<String, dynamic> json)
      : index = json['index'],
        value = json['value'],
        color = GameColor.values.byName(json['color']),
        isKey = json['isKey'] ?? false;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['index'] = index;
    data['value'] = value;
    data['color'] = color.name;
    data['isKey'] = isKey;
    return data;
  }
}

class Board {
  List<Letter> tiles;

  Board(this.tiles);

  factory Board.fromJson(Map<String, dynamic> json) {
    var tiles = <Letter>[];
    json['tiles'].forEach((tile) {
      tiles.add(Letter.fromJson(tile));
    });
    return Board(tiles);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tiles'] = tiles;
    return data;
  }
}

class Player {
  Board board;
  String name;
  Player(this.board, this.name);

  factory Player.fromJson(Map<String, dynamic> json) {
    var board = Board.fromJson(json['board']);
    var name = json['name'] as String;

    return Player(board, name);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['board'] = board;
    data['name'] = name;
    return data;
  }
}

class Context {
  List<Player> players;
  List<List<Letter>> keys;
  int currentPlayerIndex;
  String currentLetter;

  Context(this.players, this.keys, this.currentLetter, this.currentPlayerIndex);

  factory Context.fromJson(Map<String, dynamic> json) {
    var keys = <List<Letter>>[];
    if (json['keys'] != null) {
      json['keys'].forEach((row) {
        var rowKeys = <Letter>[];
        row.forEach((key) {
          var letter = Letter.fromJson(key);
          letter.isKey = true;
          rowKeys.add(letter);
        });
        keys.add(rowKeys);
      });
    }

    var players = <Player>[];
    if (json['players'] != null) {
      json['players'].forEach((key) {
        var player = Player.fromJson(key);
        players.add(player);
      });
    }

    var currentLetter = json['currentLetter'];
    var currentPlayerIndex = json['currentPlayerIndex'] as int;

    return Context(players, keys, currentLetter, currentPlayerIndex);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['players'] = players;
    data['keys'] = keys;
    data['currentPlayerIndex'] = currentPlayerIndex;
    data['currentLetter'] = currentLetter;
    return data;
  }
}
