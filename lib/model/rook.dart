import 'board.dart';
import 'piece.dart';

class Rook extends PieceMobility {
  const Rook();

  @override
  Iterable<Move> moves(Move pos, Team team, Board board) sync* {
    throw "Not implemented";
  }
}
