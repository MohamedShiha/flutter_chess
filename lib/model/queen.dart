import 'package:flutter_chess/model/bishop.dart';
import 'package:flutter_chess/model/rook.dart';

import 'board.dart';
import 'piece.dart';

class Queen extends PieceMobility {
  const Queen();

  @override
  Iterable<Move> moves(Move pos, Team team, Board board) sync* {
    yield* const Rook().moves(pos, team, board);
    yield* const Bishop().moves(pos, team, board);
  }
}
