import 'board.dart';
import 'piece.dart';

class Bishop extends PieceMobility {
  const Bishop();
  @override
  Iterable<Move> moves(Move pos, Team team, Board board) sync* {
    //  positive positive
    for (var i = 1; i < Board.size; i++) {
      var tagretMove = pos + (Move.zero.up.right * i);
      if (board.isEmpty(tagretMove)) {
        yield tagretMove;
      } else if (board.isEnemyOrEmpty(tagretMove, team)) {
        yield tagretMove;
        break;
      } else {
        break;
      }
    }
    // negative negative
    for (var i = 1; i < Board.size; i++) {
      var tagretMove = pos + (Move.zero.up.left * i);

      if (board.isEmpty(tagretMove)) {
        yield tagretMove;
      } else if (board.isEnemyOrEmpty(tagretMove, team)) {
        yield tagretMove;
        break;
      } else {
        break;
      }
    }

    // positive negative
    for (int i = 1; i < Board.size; i++) {
      var tagretMove = pos + (Move.zero.down.right * i);

      if (board.isEmpty(tagretMove)) {
        yield tagretMove;
      } else if (board.isEnemyOrEmpty(tagretMove, team)) {
        yield tagretMove;
        break;
      } else {
        break;
      }
    }

    //  negative positive
    for (var i = 1; i < Board.size; i++) {
      var tagretMove = pos + (Move.zero.down.left * i);
      if (board.isEmpty(tagretMove)) {
        yield tagretMove;
      } else if (board.isEnemyOrEmpty(tagretMove, team)) {
        yield tagretMove;
        break;
      } else {
        break;
      }
    }
  }
}
