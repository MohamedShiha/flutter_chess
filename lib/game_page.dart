import 'package:flutter/material.dart';
import 'package:flutter_chess/model/board.dart';
import 'package:flutter_chess/model/game.dart';
import 'package:flutter_chess/model/piece.dart';

import 'model/pawn.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  ChessGame game = ChessGame();

  List<Move> availableMoves = [];

  Move? selectedPiece;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Turn ${game.turn.name}'),
      ),
      body: GridView.count(
        crossAxisCount: 8,
        children: List.generate(64, (index) {
          int x = index % 8;
          int y = index ~/ 8;
          return GestureDetector(
            onTap: () {
              setState(() {
                availableMoves = [];

                var moves = game.select(x, y).toList();
                if (moves.isEmpty) return;

                availableMoves = moves.toList();
                selectedPiece = Move(x, y);
              });
            },
            child: Stack(
              children: [
                Container(
                    color: (x + y) % 2 == 0 ? Colors.grey : Colors.grey[300],
                    child: game.board[y][x] == null
                        ? Container()
                        : Image.asset(game.board[y][x]!.image)),
                if (availableMoves.any((move) => move == Move(x, y)))
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        game.play(
                            selectedPiece!,
                            availableMoves
                                .firstWhere((move) => move == Move(x, y)));

                        availableMoves = [];
                      });

                      // promote pawn
                      if (game.board[y][x]!.mobility is Pawn &&
                          (y == 0 || y == 7)) {
                        var team = game.turn;
                        game.board.board[y][x] = await showDialog<Piece>(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => Dialog(
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Text("Pawn Promotion!"),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          mainAxisSize: MainAxisSize.min,
                                          children: (team == Team.black
                                                  ? [
                                                      wQueen,
                                                      wBishop,
                                                      wKnight,
                                                      wRook,
                                                    ]
                                                  : [
                                                      bQueen,
                                                      bBishop,
                                                      bKnight,
                                                      bRook,
                                                    ])
                                              .map(
                                                (piece) => InkWell(
                                                  child: Image.asset(
                                                    piece.image,
                                                    height: 50,
                                                    width: 50,
                                                  ),
                                                  onTap: () {
                                                    Navigator.pop(
                                                        context, piece);
                                                  },
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      ]),
                                ));

                        setState(() {});
                      }
                    },
                    child: Container(color: Colors.green),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}