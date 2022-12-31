import 'board.dart';
import 'piece.dart';

class Pawn extends PieceMobility {
  const Pawn();
  @override
  Iterable<Move> moves(Move pos, Team team, Board board) sync* {
    var direction = team == Team.white ? Move.north() : Move.south();

    var tagretMove = pos + direction;
    if (board.isEmpty(tagretMove)) {
      yield tagretMove;
      int initPosition = team == Team.white ? 6 : 1;
      if (initPosition == pos.y &&
          board.isPieceFirstMove(pos) &&
          board.isEmpty(tagretMove + direction)) {
        yield tagretMove + direction;
      }
    }

    var attackEast = tagretMove.right;
    var attackWest = tagretMove.left;

    if (board.isEnemy(attackEast, team)) {
      yield attackEast;
    }
    if (board.isEnemy(attackWest, team)) {
      yield attackWest;
    }

    // test en passant

    var enPassantWest = attackWest;
    var enPassantEast = attackEast;

    if (board.isEmpty(enPassantWest) &&
        board.isEnemy(pos.left, team) &&
        board[pos.left]!.mobility is Pawn &&
        board.isPawnTwoMoves(
            pos.left, team == Team.white ? Team.black : Team.white)) {
      yield Move(enPassantWest.x, enPassantWest.y, isEnPassant: true);
    }
    if (board.isEmpty(enPassantEast) &&
        board.isEnemy(pos.right, team) &&
        board[pos.right]!.mobility is Pawn &&
        board.isPawnTwoMoves(
            pos.right, team == Team.white ? Team.black : Team.white)) {
      yield Move(enPassantEast.x, enPassantWest.y, isEnPassant: true);
    }
  }
}
