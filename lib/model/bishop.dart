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

    if (board.isInBound(pos.right) &&
        board.isInBound(pos.right.right) &&
        board.isInBound(pos.right.right.right) &&
        board.isEnemy(pos.right, team) &&
        board.isEnemy(pos.right.right, team) &&
        !board.isEnemy(pos.right.right.right, team) &&
        board[pos.right.right.right]!.mobility is Bishop) {
      yield pos.right.right.right.copyWith(type: MoveType.ilVaticano);
    }
    if (board.isInBound(pos.left) &&
        board.isInBound(pos.left.left) &&
        board.isInBound(pos.left.left.left) &&
        board.isEnemy(pos.left, team) &&
        board.isEnemy(pos.left.left, team) &&
        !board.isEnemy(pos.left.left.left, team) &&
        board[pos.left.left.left]!.mobility is Bishop) {
      yield pos.left.left.left.copyWith(type: MoveType.ilVaticano);
    }
    if (board.isInBound(pos.up) &&
        board.isInBound(pos.up.up) &&
        board.isInBound(pos.up.up.up) &&
        board.isEnemy(pos.up, team) &&
        board.isEnemy(pos.up.up, team) &&
        !board.isEnemy(pos.up.up.up, team) &&
        board[pos.up.up.up]!.mobility is Bishop) {
      yield pos.up.up.up.copyWith(type: MoveType.ilVaticano);
    }
    if (board.isInBound(pos.down) &&
        board.isInBound(pos.down.down) &&
        board.isInBound(pos.down.down.down) &&
        board.isEnemy(pos.down, team) &&
        board.isEnemy(pos.down.down, team) &&
        !board.isEnemy(pos.down.down.down, team) &&
        board[pos.down.down.down]!.mobility is Bishop) {
      yield pos.down.down.down.copyWith(type: MoveType.ilVaticano);
    }
  }
}
