import 'board.dart';
import 'piece.dart';

class King extends PieceMobility {
  const King();
  @override
  Iterable<Move> moves(Move pos, Team team, Board board) sync* {
    var moves = [
      pos.right,
      pos.right.up,
      pos.up,
      pos.left.up,
      pos.left,
      pos.left.down,
      pos.down,
      pos.down.right,
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
