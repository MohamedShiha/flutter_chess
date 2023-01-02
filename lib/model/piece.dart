import 'board.dart';

enum Team {
  white,
  black,
}

enum MoveType {
  normal,
  castle,
  enPassant,
  ilVaticano,
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
  final MoveType type;
  const Move(this.x, this.y, {this.type = MoveType.normal});

  static get zero => const Move(0, 0);

  Move.north() : this(0, -1);
  Move.south() : this(0, 1);
  Move.east() : this(1, 0);
  Move.west() : this(-1, 0);

  Move get up => Move(x, y - 1);

  Move get down => Move(x, y + 1);

  Move get right => Move(x + 1, y);

  Move get left => Move(x - 1, y);

  Move operator +(Move other) => Move(x + other.x, y + other.y);

  Move operator -(Move other) => Move(x - other.x, y - other.y);

  Move operator *(int multiplayer) => Move(x * multiplayer, y * multiplayer);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Move &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  Move copyWith({
    int? x,
    int? y,
    MoveType? type,
  }) {
    return Move(
      x ?? this.x,
      y ?? this.y,
      type: type ?? this.type,
    );
  }
}

abstract class PieceMobility {
  const PieceMobility();
  Iterable<Move> moves(Move pos, Team team, Board board);
}
