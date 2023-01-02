import 'package:flutter_chess/model/pawn.dart';
import 'package:flutter_chess/model/piece.dart';
import 'package:flutter_chess/model/queen.dart';
import 'package:flutter_chess/model/rook.dart';

import 'bishop.dart';
import 'king.dart';
import 'knight.dart';

const wPawn = Piece.white("assets/pawn_white.png", mobility: Pawn());
const bPawn = Piece.black("assets/pawn_black.png", mobility: Pawn());
const wRook = Piece.white("assets/rook_white.png", mobility: Rook());
const bRook = Piece.black("assets/rook_black.png", mobility: Rook());
const wBishop = Piece.white("assets/bishop_white.png", mobility: Bishop());
const bBishop = Piece.black("assets/bishop_black.png", mobility: Bishop());
const wKnight = Piece.white("assets/knight_white.png", mobility: Knight());
const bKnight = Piece.black("assets/knight_black.png", mobility: Knight());
const wQueen = Piece.white("assets/queen_white.png", mobility: Queen());
const bQueen = Piece.black("assets/queen_black.png", mobility: Queen());
const wKing = Piece.white("assets/king_white.png", mobility: King());
const bKing = Piece.black("assets/king_black.png", mobility: King());
const chess_board = [
  [bRook, bBishop, bKnight, bKing, bQueen, bKnight, bBishop, bRook],
  [bPawn, bPawn, bPawn, bPawn, bPawn, bPawn, bPawn, bPawn],
  [null, null, null, null, null, null, null, null],
  [null, null, null, null, null, null, null, null],
  [null, null, null, null, null, null, null, null],
  [null, null, null, null, null, null, null, null],
  [wPawn, wPawn, wPawn, wPawn, wPawn, wPawn, wPawn, wPawn],
  [wRook, wBishop, wKnight, wKing, wQueen, wKnight, wBishop, wRook],
];

class Board {
  static const int size = 8;
  final List<List<Piece?>> _board;
  List<List<Piece?>> _previous = [];

  Piece? operator [](Move m) => _board[m.y][m.x];

  void operator []=(Move m, Piece? piece) => _board[m.y][m.x] = piece;

  Board([List<List<Piece?>>? board])
      : _board = board ?? chess_board.map((e) => e.toList()).toList() {
    _previous = _board.map((e) => e.toList()).toList();
  }
  Board.test() : this();

  void move(Move from, Move to) {
    _previous = _board.map((e) => e.toList()).toList();
    _board[to.y][to.x] = _board[from.y][from.x];
    _board[from.y][from.x] = null;
  }

  bool isOutBound(Move move) =>
      move.x >= size || move.x < 0 || move.y >= size || move.y < 0;

  bool isInBound(Move move) => !isOutBound(move);

  bool isEmpty(Move move) {
    if (isOutBound(move)) return false;
    return _board[move.y][move.x] == null;
  }

  bool isEnemy(Move move, Team team) {
    if (isOutBound(move)) return false;
    if (isEmpty(move)) return false;
    return _board[move.y][move.x]!.team != team;
  }

  bool isEnemyOrEmpty(Move move, Team team) {
    return isEmpty(move) || isEnemy(move, team);
  }

  bool isPieceFirstMove(Move move) {
    return _board[move.y][move.x] == _previous[move.y][move.x];
  }

  bool isPawn(Move move) {
    if (isEmpty(move)) return false;

    return _board[move.y][move.x]!.mobility is Pawn;
  }

  bool isPawnTwoMoves(Move move, Team team) {
    if (!isPawn(move)) return false;

    var previousPosition = team == Team.white ? move.down.down : move.up.up;

    if (!isEmpty(previousPosition)) return false;

    return _previous[previousPosition.y][previousPosition.x] ==
        _board[move.y][move.x];
  }
}
