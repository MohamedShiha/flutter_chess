import 'board.dart';
import 'piece.dart';

class Rook extends PieceMobility {
  const Rook();

  @override
  Iterable<Move> moves(int x, int y, Team team, Board board) sync* {
    // horizontal positive
    for (var i = x + 1; i < Board.size; i++) {
      if (board.isEmpty(i, y)) {
        yield Move(i, y);
      } else if (board.isEnemyOrEmpty(i, y, team)) {
        yield Move(i, y);
        break;
      } else {
        break;
      }
    }
    // horizontal negative
    for (var i = x - 1; i < Board.size; i--) {
      if (board.isEmpty(i, y)) {
        yield Move(i, y);
      } else if (board.isEnemyOrEmpty(i, y, team)) {
        yield Move(i, y);
        break;
      } else {
        break;
      }
    }

    // vertical positive
    for (var i = y + 1; i < Board.size; i++) {
      if (board.isEmpty(x, i)) {
        yield Move(x, i);
      } else if (board.isEnemyOrEmpty(x, i, team)) {
        yield Move(x, i);
        break;
      } else {
        break;
      }
    }

    // vertical negative
    for (var i = y + 1; i < Board.size; i--) {
      if (board.isEmpty(x, i)) {
        yield Move(x, i);
      } else if (board.isEnemyOrEmpty(x, i, team)) {
        yield Move(x, i);
        break;
      } else {
        break;
      }
    }
  }
}
