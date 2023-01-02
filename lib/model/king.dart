import 'board.dart';
import 'piece.dart';

class King extends PieceMobility {
  final bool hasMoved;
  final bool hasRightRookMoved;
  final bool hasLeftRookMoved;

  const King({
    this.hasMoved = false,
    this.hasRightRookMoved = false,
    this.hasLeftRookMoved = false,
  });

  King copyWith({
    bool? hasMoved,
    bool? hasRightRookMoved,
    bool? hasLeftRookMoved,
  }) =>
      King(
        hasMoved: hasMoved ?? this.hasMoved,
        hasRightRookMoved: hasRightRookMoved ?? this.hasRightRookMoved,
        hasLeftRookMoved: hasLeftRookMoved ?? this.hasLeftRookMoved,
      );

  @override
  Iterable<Move> moves(Move pos, Team team, Board board) sync* {
    var moves = [
      pos.right,
      pos.right.up,
      pos.up,
      pos.left.up,
      pos.left,
      pos.left.down,
      pos.down,
      pos.down.right,
    ];

    for (var move in moves) {
      if (board.isEmpty(move)) {
        yield move;
      } else if (board.isEnemyOrEmpty(move, team)) {
        yield move;
      }
    }

    if (hasMoved) return;

    if (!hasRightRookMoved &&
        board.isEmpty(pos.right) &&
        board.isEmpty(pos.right.right) &&
        board.isEmpty(pos.right.right.right)) {
      var target = pos.right.right;
      yield Move(target.x, target.y, type: MoveType.castle);
    }
    if (!hasLeftRookMoved &&
        board.isEmpty(pos.left) &&
        board.isEmpty(pos.left.left)) {
      var target = pos.left.left;
      yield Move(target.x, target.y, type: MoveType.castle);
    }
  }
}
