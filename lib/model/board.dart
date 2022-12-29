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

class Board {
  static const int size = 8;
  List<List<Piece?>> board = [
    [bRook, bBishop, bKnight, bKing, bQueen, bKnight, bBishop, bRook],
    [bPawn, bPawn, bPawn, bPawn, bPawn, bPawn, bPawn, bPawn],
    [null, null, null, null, null, null, null, null],
    [null, null, null, null, null, null, null, null],
    [null, null, null, null, null, null, null, null],
    [null, null, null, null, null, null, null, null],
    [wPawn, wPawn, wPawn, wPawn, wPawn, wPawn, wPawn, wPawn],
    [wRook, wBishop, wKnight, wKing, wQueen, wKnight, wBishop, wRook],
  ];
  List<List<Piece?>> previous = [];

  List<Piece?> operator [](int i) => board[i];

  Board() {
    previous = board.map((e) => e.toList()).toList();
  }
  Board.test() {
    board = [
      [null, null, null, null, null, null, null, null],
      [wPawn, wPawn, wPawn, wPawn, wPawn, wPawn, wPawn, wPawn],
      [null, null, null, null, null, null, null, null],
      [null, null, null, null, null, null, null, null],
      [null, null, null, null, null, null, null, null],
      [null, null, null, null, null, null, null, null],
      [bPawn, bPawn, bPawn, bPawn, bPawn, bPawn, bPawn, bPawn],
      [null, null, null, null, null, null, null, null],
    ];
    previous = board.map((e) => e.toList()).toList();
  }

  void move(Move from, Move to) {
    previous = board.map((e) => e.toList()).toList();
    board[to.y][to.x] = board[from.y][from.x];
    board[from.y][from.x] = null;

    if (to.isEnPassant) {
      // kill the piece behind the moved pawn
      var team = board[to.y][to.x]!.team;
      board[to.y + (team == Team.white ? 1 : -1)][to.x] = null;
    }
  }

  bool _isOutBound(int x, int y) => x >= size || x < 0 || y >= size || y < 0;

  bool isEmpty(int x, int y) {
    if (_isOutBound(x, y)) return false;
    return board[y][x] == null;
  }

  bool isEnemy(int x, int y, Team team) {
    if (_isOutBound(x, y)) return false;
    if (isEmpty(x, y)) return false;
    return board[y][x]!.team != team;
  }

  bool isEnemyOrEmpty(int x, int y, Team team) {
    return isEmpty(x, y) || isEnemy(x, y, team);
  }
}
