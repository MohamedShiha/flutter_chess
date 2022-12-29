import 'board.dart';
import 'piece.dart';

class Pawn extends PieceMobility {
  const Pawn();
  @override
  Iterable<Move> moves(int x, int y, Team team, Board board) sync* {
    int direction = team == Team.white ? -1 : 1;
    if (board.isEmpty(x, y + direction)) {
      yield Move(x, y + direction);
    }

    int initPosition = team == Team.white ? 6 : 1;

    if (y == initPosition &&
        board.previous[y][x] != null &&
        board.previous[y][x]!.mobility is Pawn &&
        board.previous[y][x]!.team == team &&
        board.isEmpty(x, y + direction) &&
        board.isEmpty(x, y + (direction * 2))) {
      yield Move(x, y + (2 * direction));
    }

    if (board.isEnemy(x + 1, y + direction, team)) {
      yield Move(x + 1, y + direction);
    }
    if (board.isEnemy(x - 1, y + direction, team)) {
      yield Move(x - 1, y + direction);
    }

    // test en passant
    if (board.isEmpty(x + 1, y + direction) &&
        board.isEnemy(x + 1, y, team) &&
        board[y][x + 1]!.mobility is Pawn &&
        board.previous[team == Team.black ? 6 : 1][x + 1] != null &&
        board.previous[team == Team.black ? 6 : 1][x + 1]!.mobility is Pawn &&
        board[team == Team.black ? 6 : 1][x + 1] == null) {
      yield Move(x + 1, y + direction, isEnPassant: true);
    }
    if (board.isEmpty(x - 1, y + direction) &&
        board.isEnemy(x - 1, y, team) &&
        board[y][x - 1]!.mobility is Pawn &&
        board.previous[team == Team.black ? 6 : 1][x - 1] != null &&
        board.previous[team == Team.black ? 6 : 1][x - 1]!.mobility is Pawn &&
        board[team == Team.black ? 6 : 1][x - 1] == null) {
      yield Move(x - 1, y + direction, isEnPassant: true);
    }
  }
}
