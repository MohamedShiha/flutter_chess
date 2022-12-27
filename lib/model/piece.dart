enum Team {
  white,
  black,
}

class Move {
  int x;
  int y;
  Move(this.x, this.y);
}

class Board {
  List<List<Piece?>> board = List.generate(8, (i) => List.filled(8, null));
}

abstract class Piece {
  Team team;
  String image;

  Piece({required this.team, required this.image});

  Stream<Move> moves(int x, int y, Board board);
}
