import 'package:flutter_chess/model/board.dart';

import 'piece.dart';

class ChessGame {
  Board board = Board.test();

  Team turn = Team.white;

  void play(Move from, Move to) {
    board.move(from, to);
    turn = turn == Team.white ? Team.black : Team.white;
  }

  Iterable<Move> select(int x, int y) sync* {
    if (board[y][x] == null) return;

    if (board[y][x]?.team != turn) return;

    yield* board[y][x]!.mobility.moves(x, y, turn, board);
  }

  void isGameOver() {
    // game ends if current player has no moves
  }
}
