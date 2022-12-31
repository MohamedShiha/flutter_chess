import 'board.dart';
import 'piece.dart';

class Rook extends PieceMobility {
  const Rook();

  @override
  Iterable<Move> moves(Move pos, Team team, Board board) sync* {
    // horizontal positive
    for (var i = 1; i < Board.size; i++) {
      var target = pos + (Move.zero.up * i);
      if (board.isEmpty(target)) {
        yield target;
      } else if (board.isEnemyOrEmpty(target, team)) {
        yield target;
        break;
      } else {
        break;
      }
    }
    // horizontal negative
    for (var i = 1; i < Board.size; i++) {
      var target = pos + (Move.zero.left * i);

      if (board.isEmpty(target)) {
        yield target;
      } else if (board.isEnemyOrEmpty(target, team)) {
        yield target;
        break;
      } else {
        break;
      }
    }

    // vertical positive
    for (var i = 1; i < Board.size; i++) {
      var target = pos + (Move.zero.down * i);

      if (board.isEmpty(target)) {
        yield target;
      } else if (board.isEnemyOrEmpty(target, team)) {
        yield target;
        break;
      } else {
        break;
      }
    }

    // vertical negative
    for (var i = 1; i < Board.size; i++) {
      var target = pos + (Move.zero.right * i);

      if (board.isEmpty(target)) {
        yield target;
      } else if (board.isEnemyOrEmpty(target, team)) {
        yield target;
        break;
      } else {
        break;
      }
    }
  }
}
