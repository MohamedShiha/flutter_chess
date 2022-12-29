import 'package:flutter_chess/model/bishop.dart';
import 'package:flutter_chess/model/rook.dart';

import 'board.dart';
import 'piece.dart';

class Queen extends PieceMobility {
  const Queen();

  @override
  Iterable<Move> moves(int x, int y, Team team, Board board) sync* {
    yield* Rook().moves(x, y, team, board);
    yield* Bishop().moves(x, y, team, board);
  }
}
