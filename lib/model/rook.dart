import 'board.dart';
import 'piece.dart';

class Rook extends PieceMobility {
  const Rook();

  bool isInsideBoard(Move pos) {
    // Helper function to check if a position is within board bounds
    // A better solution is to encapsulate it inside the Board class.
    return pos.x >= 0 && pos.x < Board.size && pos.y >= 0 && pos.y < Board.size;
  }

  @override
  Iterable<Move> moves(Move pos, Team team, Board board) sync* {
    // Define directional moves (up, down, left, right)
    final List<Move> directions = [
      Move.zero.up,
      Move.zero.down,
      Move.zero.right,
      Move.zero.left,
    ];
    for (var direction in directions) {
      for (var i = 1; i < Board.size; i++) {
        var target = pos + (direction * i);

        // Safety check: stop if target is out of board bounds
        if(!isInsideBoard(target)) {
          break;
        }

        if (board.isEmpty(target)) {
          yield target;
        } else if (board.isEnemyOrEmpty(target, team)) {
          yield target;
          break; // Stop if we encounter an enemy or empty space
        } else {
          break; // Stop if we encounter a piece of the same team
        }
      }
    }
  }
}
