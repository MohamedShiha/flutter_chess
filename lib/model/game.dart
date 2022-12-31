import 'package:flutter_chess/model/board.dart';

import 'piece.dart';

class ChessGame {
  Board board = Board();

  Team turn = Team.white;

  void play(Move from, Move to) {
    board.move(from, to);
    turn = turn == Team.white ? Team.black : Team.white;
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
