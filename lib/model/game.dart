import 'package:flutter_chess/model/board.dart';
import 'package:flutter_chess/model/rook.dart';

import 'king.dart';
import 'piece.dart';

class ChessGame {
  Board board = Board.test();

  Team turn = Team.white;

  void play(Move from, Move to) {
    board.move(from, to);

    if (board[to]!.mobility is King) {
      (board[to]!.mobility as King).hasMoved = true;
    }

    if (board[to]!.mobility is Rook && (from.y == 0 || from.y == 7)) {
      if (to.x == 0) {
        (board[locateKing()]!.mobility as King).hasLeftRookMoved = true;
      } else {
        (board[locateKing()]!.mobility as King).hasRightRookMoved = true;
      }
    }

    if (to.type == MoveType.enPassant) {
      // kill the piece behind the moved pawn
      board[to + (turn == Team.black ? Move.north() : Move.south())] = null;
    } else if (to.type == MoveType.castle) {
      var castleY = turn == Team.white ? 7 : 0;
      var castle = to.x == 1 ? Move(0, castleY) : Move(7, castleY);

      board.move(castle, to.x == 1 ? to.right : to.left);
    } else if (to.type == MoveType.ilVaticano) {
      board[from] = board[to];

      if (to.y == from.y) {
        var middle = (to.x + from.x) ~/ 2;
        board[Move(middle, to.y)] = null;
        board[Move(middle + 1, to.y)] = null;
      } else {
        var middle = (to.y + from.y) ~/ 2;
        board[Move(to.x, middle)] = null;
        board[Move(to.x, middle + 1)] = null;
      }
    }

    turn = turn == Team.white ? Team.black : Team.white;
  }

  // bool isCheck() {}

  Move locateKing() {
    for (var i = 0; i < 8; i++) {
      for (var j = 0; j < 8; j++) {
        if (!board.isEmpty(Move(i, j)) &&
            board[Move(i, j)]!.mobility is King &&
            board[Move(i, j)]!.team == turn) {
          return Move(i, j);
        }
      }
    }
    throw "King not found";
  }

  Iterable<Move> select(Move pos) sync* {
    if (board[pos] == null) return;

    if (board[pos]?.team != turn) return;

    yield* board[pos]!.mobility.moves(pos, turn, board);
  }

  void isGameOver() {
    // game ends if current player has no moves
  }
}
