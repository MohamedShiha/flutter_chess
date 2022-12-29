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
  int x;
  int y;
  bool isEnPassant;
  Move(this.x, this.y, {this.isEnPassant = false});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Move &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}

abstract class PieceMobility {
  const PieceMobility();
  Iterable<Move> moves(int x, int y, Team team, Board board);
}
