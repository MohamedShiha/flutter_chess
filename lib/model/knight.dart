import 'board.dart';
import 'piece.dart';

class Knight extends PieceMobility {
  const Knight();
  @override
  Iterable<Move> moves(int x, int y, Team team, Board board) sync* {
    var moves = [
      Move(x + 1, y + 2),
      Move(x + 1, y - 2),
      Move(x - 1, y + 2),
      Move(x - 1, y - 2),
      Move(x + 2, y + 1),
      Move(x + 2, y - 1),
      Move(x - 2, y + 1),
      Move(x - 2, y - 1),
    ];

    for (var move in moves) {
      if (board.isEmpty(move.x, move.y)) {
        yield move;
      } else if (board.isEnemyOrEmpty(move.x, move.y, team)) {
        yield move;
      }
    }
  }
}
