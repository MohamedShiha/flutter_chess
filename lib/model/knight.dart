import 'board.dart';
import 'piece.dart';

class Knight extends PieceMobility {
  const Knight();
  @override
  Iterable<Move> moves(Move pos, Team team, Board board) sync* {
    var moves = [
      pos.right.up.up,
      pos.right.down.down,
      pos.right.right.down,
      pos.right.right.up,
      pos.left.up.up,
      pos.left.down.down,
      pos.left.left.down,
      pos.left.left.up,
    ];

    for (var move in moves) {
      if (board.isEmpty(move)) {
        yield move;
      } else if (board.isEnemyOrEmpty(move, team)) {
        yield move;
      }
    }
  }
}
