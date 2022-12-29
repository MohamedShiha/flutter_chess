import 'board.dart';
import 'piece.dart';

class Bishop extends PieceMobility {
  const Bishop();
  @override
  Iterable<Move> moves(int x, int y, Team team, Board board) sync* {
    //  positive positive
    for (var i = 1; i < Board.size; i++) {
      if (board.isEmpty(x + i, y + i)) {
        yield Move(x + i, y + i);
      } else if (board.isEnemyOrEmpty(x + i, y + i, team)) {
        yield Move(x + i, y + i);
        break;
      } else {
        break;
      }
    }
    // negative negative
    for (var i = 1; i < Board.size; i++) {
      if (board.isEmpty(x - i, y - i)) {
        yield Move(x - i, y - i);
      } else if (board.isEnemyOrEmpty(x - i, y - i, team)) {
        yield Move(x - i, y - i);
        break;
      } else {
        break;
      }
    }

    // positive negative
    for (var i = 1; i < Board.size; i++) {
      if (board.isEmpty(x - i, y + i)) {
        yield Move(x - i, y + i);
      } else if (board.isEnemyOrEmpty(x - i, y + i, team)) {
        yield Move(x - i, y + i);
        break;
      } else {
        break;
      }
    }

    //  negative positive
    for (var i = 1; i < Board.size; i++) {
      if (board.isEmpty(x - i, y + i)) {
        yield Move(x - i, y + i);
      } else if (board.isEnemyOrEmpty(x - i, y + i, team)) {
        yield Move(x - i, y + i);
        break;
      } else {
        break;
      }
    }
  }
}
