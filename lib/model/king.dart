import 'board.dart';
import 'piece.dart';

class King extends PieceMobility {
  const King();
  @override
  Iterable<Move> moves(int x, int y, Team team, Board board) sync* {
    var moves = [
      Move(x + 1, y),
      Move(x + 1, y + 1),
      Move(x, y + 1),
      Move(x - 1, y + 1),
      Move(x - 1, y),
      Move(x - 1, y - 1),
      Move(x, y - 1),
      Move(x + 1, y - 1),
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
