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
  List<List<Piece?>> board = [
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
  ];
}

abstract class Piece {
  Team team;
  String image;

  Piece({required this.team, required this.image});

  Stream<Move> moves(int x, int y, Board board);
}

class Pawn extends Piece {
  Pawn({
    required super.team,
    required super.image,
  });

  @override
  Iterable<Move> moves(int x, int y, Board board)  sync*{

    if()
    
  }
}
