import 'board.dart';

enum Team {
  white,
  black,
}

class Piece {
  final Team team;
  final String image;

  final PieceMobility mobility;

  const Piece(
    this.image, {
    required this.team,
    required this.mobility,
  });

  const Piece.white(
    this.image, {
    required this.mobility,
  }) : team = Team.white;

  const Piece.black(
    this.image, {
    required this.mobility,
  }) : team = Team.black;
}

class Move {
  final int x;
  final int y;
  final bool isEnPassant;
  const Move(this.x, this.y, {this.isEnPassant = false});

  static get zero => const Move(0, 0);

  Move.north()
      : x = 0,
        y = -1,
        isEnPassant = false;
  Move.south()
      : x = 0,
        y = 1,
        isEnPassant = false;
  Move.east()
      : x = 1,
        y = 0,
        isEnPassant = false;
  Move.west()
      : x = -1,
        y = 0,
        isEnPassant = false;

  Move.identical(int d, {this.isEnPassant = false})
      : x = d,
        y = d;

  Move get up {
    return Move(x, y - 1);
  }

  Move get down {
    return Move(x, y + 1);
  }

  Move get right {
    return Move(x + 1, y);
  }

  Move get left {
    return Move(x - 1, y);
  }

  Move operator +(Move other) {
    return Move(x + other.x, y + other.y);
  }

  Move operator -(Move other) {
    return Move(x - other.x, y - other.y);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Move &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y;

  Move operator *(int multiplayer) => Move(x * multiplayer, y * multiplayer);

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}

abstract class PieceMobility {
  const PieceMobility();
  Iterable<Move> moves(Move pos, Team team, Board board);
}
